using EquilibriumMeasures, StaticArrays
using Plots


"""
Try finding multiple solutions of 2 interval problem.
"""

# Potential
# V = x -> (x-4)*(x-3)*(x-2)*(1+x)*(2+x)*(3+x)*(2x-1)*(x+4)/1e3
V = x -> (x-3)*(x-2)*(1+x)*(2+x)*(3+x)*(2x-1)/20

# Initial guess
ic = SVector(-2.5,-2.3,2.3,2.5)

# First solution global solution
μ, a = equilibriummeasure(V; a=ic, returnendpoint=true)
solns_endpoints = [a]
solns_measure = [μ]

μ, b = equilibriummeasure(V; a=ic, knownsolutions=solns_endpoints, dampening=0.6, returnendpoint=true)
push!(solns_endpoints, b)
push!(solns_measure, μ)

# First solution
μ, a = equilibriummeasure(V; a=ic, returnendpoint=true, globalmin=false)

# Keep first solution in an array
solns_endpoints = [a]
solns_measure = [μ]

# # Sanity check that energy is constant over each interval. 
import ClassicalOrthogonalPolynomials: components
import IntervalSets: leftendpoint, rightendpoint
x = axes(μ,1)
a1,a2 = components(x.domain)
a1range = leftendpoint(a1):0.05:rightendpoint(a1)
a2range = leftendpoint(a2):0.05:rightendpoint(a2)
y1 = Array{Float64}(undef, length(a1range))
for (xx, j) = zip(a1range, 1:length(a1range))
    y1[j] = 2*(log.(abs.(xx .- x'))*μ) - V(xx)
end
y2 = Array{Float64}(undef, length(a2range))
for (xx, j) = zip(a2range, 1:length(a2range))
    y2[j] = 2*(log.(abs.(xx .- x'))*μ) - V(xx)
end
plot(a1range,y1)
plot!(a2range,y2)

# Try same guess again
μ, b = equilibriummeasure(V; a=ic, knownsolutions=solns_endpoints, dampening=0.8, returnendpoint=true, globalmin=false)
push!(solns_endpoints, b)
push!(solns_measure, μ)

μ, b = equilibriummeasure(V; a=ic, knownsolutions=solns_endpoints, dampening=0.8, returnendpoint=true, globalmin=false)
push!(solns_endpoints, b)
push!(solns_measure, μ)


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