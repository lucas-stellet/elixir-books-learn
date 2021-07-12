defmodule ListAndRecursion.Exercices do
  def span(from, to) when from > to, do: []

  def span(from, to) do
    [from | span(from + 1, to)]
  end
end

# 1 to 4
# [1 | [2, 4]]
# [1, 2 | [3, 4]]
# [1, 2, 3 | [3 + 1]]
