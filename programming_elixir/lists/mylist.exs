defmodule MyList do
  def len([]), do: 0
  def len([_hd | tl]), do: 1 + len(tl)

  def square([]), do: []
  def square([hd | tl]), do: [hd * hd | square(tl)]

  def add_1([]), do: []
  def add_1([hd | tl]), do: [hd + 1 | add_1(tl)]

  def map([], _func), do: []
  def map([hd | tl], func), do: [func.(hd) | map(tl, func)]

  def reduce([], value, _), do: value

  def reduce([hd | tl], value, func), do: reduce(tl, func.(hd, value), func)

  def mapsum([], _func), do: 0

  def mapsum([hd | tl], func) do
    func.(hd) + mapsum(tl, func)
  end
end
