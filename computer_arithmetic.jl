#= The IEEE 64-bit floating-point representation is the specific model used in most computers today:

x = (-1)^s(1.a_2a_3a_4....a_53)2^(e-1023)

- 1 bit for `s`
- 11 bits for `e`: This means 0 ≤ e ≤ 2047 ⟹ -1023 ≤ e-1023 ≤ 1024
- 52 bits for `a_2 ... a_53`
=#
using Plots

# IEEEFloat is also a type in Julia
Float32 <: Base.IEEEFloat

# `bitstring` and `significand` commands
bitstring(10.375)

# significand grows linearly from 1 to 2 for each interval (2^n, 2^(n+1))
plot([significand(i) for i in 1.0:0.111:100.0])

#= Special cases: zero, infinity, NAN
In the floating-point arithmetic there are two zeros: +0.0 and −0.0

For +∞ and -∞, all the exponent bits are set to 1 and all mantissa bits are set to 0
=#
bitstring(0.0)
bitstring(-0.0)

bitstring(Inf)
bitstring(-Inf)

#=
In conclusion, even though −1023 ≤ e − 1023 ≤ 1024, when it comes to representing non-zero real numbers, we only have access to exponents in the following range: −1022 ≤ e − 1023 ≤ 1023.
=#

#=
Representation of integers

Two's complement approach is used, which has advantages over the more obvious appraoch of assigning one bit for sign and the rest for magnitude.

Central idea: -x = 1 + (bits of x flipped)

Using 64 bits, one can represent integers between -2^63=-9223372036854775808 and 2^63-1=9223372036854775807
=#

bitstring(5)
bitstring(-5)
# "0111111111111111111111111111111111111111111111111111111111111111"
bitstring(9223372036854775807)
# "1000000000000000000000000000000000000000000000000000000000000000"
bitstring(-9223372036854775808)

#=
An example: calculate n^n/factorial(n) for as large n as possible
=#

f1(n) = n^n/factorial(n)

# this only works for the first 15 numbers
[f1(i) for i in 1:20]

function f2(n)
    output = 1
    for i in 1:n-1
        output *= n/(n-i)
    end
    output
end

# works for n as high as 700
[f2(i) for i in 1:20]

f2(700)

#=
Approximation and error
- two ways to approximate: chopping and rounding
- absolute and relative error: related error is usually a better choice of measure

The number x' is said to approximate x to `s` approximate digits if `s` is the largest positive number such that:
relative_error(x,x') ≤ 5 * 10^(-s)

relative_error(x,x') ≤ 10^-(k-1) if chopping, 0.5 * 10^-(k-1) if rounding

for binary numbers, replace 10 with 2 and k with 53 and everything else still holds.
=#

#=
Machine epsilon
Machine epsilon ϵ is the smallest positive floating point number for which fl(1+ϵ) > 1. This means, if we add to 1.0 any number less than ϵ, the machine computes the sum as 1.0. The answer depends on whether we chop or round.

ϵ = 2^(-52) if chopping, 2^(-53) if rounding.

Thus relative_error(x,x') ≤ ϵ
=#

#=
Propagation of error
Case 1. Subtraction of nearly equal identities

Let x = 1.123456, y = 1.123447 and consider 6 digit arithmetic. Then: fl(x) = 1.12346, fl(y) = 1.12345.

absolute_error(x, fl(x)) = 4*10^-6
absolute_error(y, fl(y)) = 3*10^-6
relative_error(x, fl(x)) = 3.56*10^-6
relative_error(y, fl(y)) = 2.67*10^-6

Now x - y = 9*10^-6
fl(fl(x)-fl(y)) = 10^-5
Thus the absolute and relative errors are 10^-6 and 0.1.

Case 2. Division by a small number.

Case 3. Addition of many numbers (due to rounding or chopping)

Some ways to reduce error propagation:
- algebriac manipulation (eg evaluate (1-cos(x))/sin(x) for x near 0, rationalize numerator of quadratic equation)
- Change the order of calculation. Eg to calculate mean(a,b), a + (b-a)/2 may be more precise than (a+b)/2, E[(x-mean)^2] is more precise than E[x^2]-(E[x])^2

Eg: Compute e^-7 = 1 + -7/1 + (-7)^2/2 + ...
=#

function f1(n)
    output = 1.0
    for i in 1:n
        output += (-7)^i/factorial(i)
    end
    output
end

function f2(n)
    output = 1.0
    for i in 1:n
        output += (7^i)/factorial(i)
    end
    1/output
end

f1(20)
f2(20)

abs(-5.5)

# let's calculate the relative error
relative_error(x,almost_x) = abs((x-almost_x)/x)
# relative error 9.1
relative_error(exp(-7), f1(20))
# relative error 1.4*10^-5
relative_error(exp(-7), f2(20))

#=
Polynomials can be evaluated using Horner's method which is not only faster but also reduces the roundoff error
p(x) = a0 + x(a1 + x(a2 + ... + x(an−1 + x(an))...)).

Julia's `evalpoly` uses Horner's method
=#

# evaluate 1+2x+x^2 at x=4
evalpoly(4, (1,2,1))