#=
The secant function uses a linear function to pass through (p0, f(p0)) and (p1, f(p1)).

Muller's method takes three initial approximations (p0, f(p0)), (p1, f(p1)) and (p2, f(p2)) and passes a parabola through them, and uses the closer of the two roots of the polynomial as the next iterate.
=#

function muller(f::Function, p0, p1, p2, eps, N)
    for i = 1:N
        c = f(p2)
        b1 = (p0-p2)*(f(p1)-f(p2))/((p1-p2)*(p0-p1))
        b2 = (p1-p2)*(f(p0)-f(p2))/((p0-p2)*(p0-p1))
        b = b1-b2
        a1=(f(p0)-f(p2))/((p0-p2)*(p0-p1))
        a2=(f(p1)-f(p2))/((p1-p2)*(p0-p1))
        a=a1-a2
        d=(Complex(b^2-4*a*c))^0.5
        if abs(b-d)<abs(b+d)
            inc=2c/(b+d)
        else
            inc=2c/(b-d)
        end
        p = p2-inc
        if f(p)==0 || abs(p-p2)<eps
            println("Found a solution $p at time step $i")
            return p
        end
        p0 = p1
        p1 = p2
        p2 = p
    end
    println("Solution did not converge. Returning $p2")
    p2
end

p = muller(x->x^5+2x^3-5x-2,0.5,1.0,1.5,10^(-5.),10)

p = muller(x->x^5+2x^3-5x-2,0.5,0,-0.1,10^(-5.),10)

p = muller(x->x^5+2x^3-5x-2,0,-0.1,-1,10^(-5.),10)

# can also find complex root
p = muller(x->x^5+2x^3-5x-2,5,10,15,10^(-5.),20)

#=
1. Muller's method can find real as well as complex roots
2. Superlinear convergence
3. Converges for a variety of starting values
=#