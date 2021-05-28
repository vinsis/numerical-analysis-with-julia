#=
### The big idea for finding a root to the equation f(x) = 0

Find a sequence p_1, p_2, ... which converges towards the actual solution `p`. Stop when you are close enough. There are three ways to determine when to stop:
1. |p_N - p_{N-1}| < ϵ
2. |(p_N - p_{N-1}) / p_N| < ϵ
3. |f(p_N)| < ϵ

- It is possible to have a sequence {pn} such that pn − pn−1 → 0 but {pn} diverges. Eg p_n = 1/n
- It is possible to have |f(p_N)| small but p_N not close to p. Eg for f(x)=x^10, p_N = 0.5 gives `f(p_N)` < 10-3 but 0.5 is far from the actual root 0.0

=#

f(x) = x^10
# 0.0009765625
abs(f(0.5)) < 10e-3

#=
Error analysis for iterative methods

Suppose {p_n} converges to p. If there exist positive C and α such that 

|p_{n+1} - p_n| ≤ C|p_n - p_{n-1}|^α for n ≥ 1, then we say that {p_n} converges to p with order α.

=#