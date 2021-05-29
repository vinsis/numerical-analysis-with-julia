#=
Fixed point problem: find p such that g(p) = p
Root finding problem: find p such that f(p) = 0

These can be connected by defining g(x) = x - f(x) but this is not the only way.

Some theorems:
1. If g is a continuous function in [a,b] and g(x) ϵ [a,b] ∀ x then g has at least one fixed point p i.e. g(p) = p.
2. Moreover the fixed point is unique if |g(x)-g(y)| ≤ λ|x-y| for 0 < λ < 1 ∀ x,y. If the function is diffentiable then the fixed point is unique if |g'(x)| ≤ k for 0 < k < 1 ∀ x.
Eg f(x) = x^3 - 2x^2 - 1. g(x) = x - f(x) doesn't work but g(x) = (2x^2+1)^(1/3) works.

3. If the above two conditions are satisfied then the fixed-point iteration p_n = g(p_{n-1}) converges to the fixed point p.

It helps to see the series as {p0, g(p0), g(g(p0)), g(g(g(p0))), ...}

Then we have: |p - p_n| = |g(p) - g(p_{n-1})| ≤ λ|p - p_{n-1}|

Error bounds:
1. |p - p_n| ≤ 1/(1-λ)|p_{n+1} - p_n|
2. |p - p_{n+1}| ≤ λ/(1-λ)|p_{n+1} - p_n|
3. |p - p_n| ≤ (λ^n/(1-λ))|p_1 - p_0|
4. |p - p_n| ≤ max{p_0-a, b-p_0}
=#

function fixed_point_iteration(f::Function, p0, eps, N)
    for i=1:N
        p = f(p0)
        if f(p) == 0 || abs(p-p0) ≤ eps
            println("Found solution $p at iteration $i")
            return p
        end
        p0 = p
    end
    println("Could not converge. Returning $p0")
    p0
end

fixed_point_iteration(x->(2x^2+1)^(1/3.),1,10^-4.,30)

fixed_point_iteration(x->x-(x^2-2)/4,1.5,10^-5.,15)

fixed_point_iteration(x->x-(x^2-2)/4,2,10^-5.,15)

fixed_point_iteration(x->x-(x^2-2)/4,-5.,10^-5.,15)

#=
Note that the convergence here is linear since |p-p_{n+1}| ≤ k |p-p_n|.
=#