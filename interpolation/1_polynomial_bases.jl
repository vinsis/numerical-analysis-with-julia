#=
Data: Points (x_i, y_i), i = 0,1,2,..,n
Basis of family of polynomials: 
- Monomial basis: ϕ_k(x) = x^k
- Lagrange basis: ϕ_k(x) = ∏_{j=0,j≠k}^{n} \frac{x - x_j}{x_k - x_j}
- Newton basis: ϕ_k(x) = ∏_{j=0}^{k-1} (x - x_j)
where k = 0,1,2,...,n
=#

using Plots

# Let's visualize different basis functions
function monomial(k)
    x -> x^k
end

plot(monomial(0).(0:0.01:1))
for i=1:5
    plot!(monomial(i).(0:0.01:1))
end
current()

# note that the other two basis functions depend on the input data (x_i, y_i)
        
#=
When using monomial basis, one can express the data as:
Ac = y where A is (n+1,n+1) matrix where each row is [1 x_0 x_0^2 ... x_0^n]
and the coefficient vector c is unknown.
The matrix A is known as van der Monde matrix. 

> This is usually an ill-conditioned matrix, which means solving the system of equations could result in large error in the coefficients a_i

The corresponding matrix when using Lagrange basis is just an identity matrix. But evaluation, differentiation and integration is quite expensive in this basis.

The corresponding matrix when using Newton basis is lower triangular and `a` can be solved by forward substitution.

> Evaluating the polynomials can be done efficiently using Horner’s method for monomial and Newton forms.
=#

