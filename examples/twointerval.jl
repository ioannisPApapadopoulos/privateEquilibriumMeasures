using EquilibriumMeasures, StaticArrays
using Plots

"""
Try finding multiple solutions of 2 interval problem.
"""

# Potential
V = x -> (x-4)*(x-3)*(x-2)*(1+x)*(2+x)*(3+x)*(2x-1)*(x+4)/1e3

# Initial guess
ic = SVector(-3,-1,1,3)

# First solution
μ, a = equilibriummeasure(V; a=ic, returnendpoint=true)

# Keep first solution in an array
solns_endpoints = [a]
solns_measure = [μ]

# Try different initial guesses
# ic = SVector(-1,-0.5,0.5,1)
# b = equilibriummeasure(V; a=ic, knownsolutions=solns, dampening=0.7, returnendpoint=true)[2]
# push!(solns, b)

# # Try same guess again
# b = equilibriummeasure(V; a=ic, knownsolutions=solns, dampening=0.7, returnendpoint=true)[2]
# push!(solns, b)

# ic = SVector(-4,-3,3,4)
# b = equilibriummeasure(V; a=ic, knownsolutions=solns, dampening=0.3, returnendpoint=true)[2]
# push!(solns, b)


# Plot solutions
p = plot()
for i = 1:length(solns_measure)
    p = plot!(solns_measure[i], legend=:top)
end

display(p)
# savefig(p, "em.pdf")