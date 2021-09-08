defmodule Stack do
  @moduledoc false

  def pop!(stack) when not is_list(stack), do: raise_not_list_error()

  def pop!(stack) do
    {element_popped, _} = List.pop_at(stack, -1)

    element_popped
  end

  def push!(stack, _element) when not is_list(stack),
    do: raise_not_list_error()

  def push!(stack, element), do: List.insert_at(stack, -1, element)

  defp raise_not_list_error(), do: raise(RuntimeError, "Stack is not a list.")
end
