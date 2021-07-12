# Write a function gcd(x,y) that finds the greatest common divisor between
# two nonnegative integers. Algebraically, gcd(x,y) is x if y is zero; it’s gcd(y,
# rem(x,y)) otherwise.

defmodule Ex do
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)
end
