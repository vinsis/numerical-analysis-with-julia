#=
Big idea: Instead of having to rely on knowning f' which might not be practical in many cases, approximate f' by:

f' ≈ ( f(p_{n-1}) - f(p_{n-2} ) / ( p_{n-1} - p_{n-2} ).

The recursion then becomes:

p_n = p_{n-1} - f(p_{n-1}) * ( p_{n-1} - p_{n-2} ) / ( f(p_{n-1}) - f(p_{n-2} ) for n ≥ 2.

Note:
- The recursion requires two initial guesses: p0, p1
=#

function secant(f::Function, p0, p1, eps, N)
    for i=1:N
        p = p1 - f(p1)*(p1-p0)/(f(p1)-f(p0))
        if f(p) == 0.0 || abs(p-p1) ≤ eps
            println("Found solution $p at iteration $i")
            return p
        end
        p0 = p1
        p1 = p
    end
    println("Solution did not converge. Returning $p1")
    p1
end

p = secant(x-> cos(x)-x,0.5,1,10^(-4.),20)