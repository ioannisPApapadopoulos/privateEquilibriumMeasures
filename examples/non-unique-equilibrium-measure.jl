using EquilibriumMeasures, StaticArrays
using Plots

"""
This script finds 9 solutions for the equilibrium measure of which 3 are feasible. 
"""

# Potential
V = x -> (x-3)*(x-2)*(1+x)*(2+x)*(3+x)*(2x-1)/20

# Initial guess
ic = SVector(-1,1)

# First solution
μ, a = equilibriummeasure(V; a=ic, returnendpoint=true)

# Keep first solution in an array
solns_endpoints = [a]
solns_measure = [μ]

for no_sols = 1:2
    
    # Compute next solution with the same initial guess but deflating
    # all other known solutions
    b = equilibriummeasure(V; a=ic, knownsolutions=solns, dampening=0.5, returnendpoint=true)[2]

    # Append array of known solutions with new solution
    push!(solns, b)

end

# Try different damping
μ, b = equilibriummeasure(V; a=ic, knownsolutions=solns_endpoints, dampening=0.3, returnendpoint=true)
push!(solns_endpoints, b)
push!(solns_measure, μ)

# Try different initial guesses
ic = SVector(2,3)
μ, b = equilibriummeasure(V; a=ic, knownsolutions=solns_endpoints, dampening=0.5, returnendpoint=true)
push!(solns_endpoints, b)
push!(solns_measure, μ)

ic = SVector(1,3)
μ, b = equilibriummeasure(V; a=ic, knownsolutions=solns_endpoints, dampening=0.5, returnendpoint=true)
push!(solns_endpoints, b)
push!(solns_measure, μ)

ic = SVector(-1,4)
μ, b = equilibriummeasure(V; a=ic, knownsolutions=solns_endpoints, dampening=0.5, returnendpoint=true)
push!(solns_endpoints, b)
push!(solns_measure, μ)

μ, b = equilibriummeasure(V; a=ic, knownsolutions=solns_endpoints, dampening=0.4, returnendpoint=true)
push!(solns_endpoints, b)
push!(solns_measure, μ)

μ, b = equilibriummeasure(V; a=ic, knownsolutions=solns_endpoints, dampening=0.5, returnendpoint=true)
push!(solns_endpoints, b)
push!(solns_measure, μ)

# Plot solutions
for i = 1:length(solns_measure)
    p = plot!(solns_measure[i], legend=:top)
end

display(p)
# savefig(p, "em.pdf")