#=
Big idea: If a function is C^3[a,b] and first derivative is known then:

if p_n ≈ p, we have (f(p) - f(p_n)) / (p - p_n) ≈ f'(p_n). But since f(p) = 0, this gives us:

    p ≈ p_n - f(p_n)/f'(p_n)

Summary: Start with an approximation p_0 to p and generate a series {p_n} by:

p_n = p_{n-1} - f(p_{n-1}) / f'(p_{n-1}) for n ≥ 1

Note:
1. It will fail if f'(p_n) = 0 for some n
2. It may fail to converge if p_0 is not close to p
3. It requires f'(x) to be known explicitly
=#

function newton(f::Function, fprime::Function, p_prev, eps, N)
    for i=1:N
        difference = - f(p_prev)/fprime(p_prev)
        p_prev += difference
        if f(p_prev) == 0 || abs(difference) ≤ eps
            println("Found solution $p_prev at time step $i")
            return p_prev
        end
    end
    println("p did not converge in $N steps. Returning $p_prev")
    p_prev
end

p = newton(x -> x^5+2x^3-5x-2,x->5x^4+6x^2-5,1,10^(-4.),20)

#=
This converges in only 6 steps compared to 16 steps required by bisection method.
=#

p = newton(x -> x^5+2x^3-5x-2,x->5x^4+6x^2-5, 0,10^(-4.),20)

p = newton(x -> x^5+2x^3-5x-2,x->5x^4+6x^2-5, -2,10^(-4.),20)

#=
Newton's method has quadratic convergence
=#