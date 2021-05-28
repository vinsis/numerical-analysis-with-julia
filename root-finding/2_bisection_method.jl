#=
Big idea: start with an interval [a_1,b_1] and keep shrinking it to [a_2, b_2], [a_3, b_3] and so on.
Stop when |b_n-a_n| < ϵ

Each interval has the property that f(a_i)f(b_i) < 0.

One can also define an upper bound N for the number of terms in the sequence {[a_i, b_i]}
=#

# Function is abstract type of all functions
function bisection(f::Function, a, b, eps, N)
    c=0
    for i=1:N
        c = a + (b-a)/2.0
        if f(c) == 0.0 || abs(a-b) ≤ eps
            println("Found a solution $c at step $i")
            return c
        end
        if f(a)*f(c) < 0
            b = c
        else
            a = c
        end
    end
    println("Could not converge to a solution after $N steps. Returning $c")
    return c
end

p = bisection(x -> x^5+2x^3-5x-2, 0, 2, 10^(-4.), 20)
p = bisection(x -> x^5+2x^3-5x-2, 0, 2, 10^(-4.), 5)

#=
The bisection method produces a sequence {p_n} with the property:

|p_n - p| ≤ abs(b-a) / 2^n for n ≥ 1

Thus it has linear convergence. 

To ensure that |p_n - p| ≤ 10^(-L) for some L, we have:

n ≥ log2((b-a)/10^(-L))
=#
