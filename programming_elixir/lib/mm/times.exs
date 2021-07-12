defmodule Times do
  def double(n) when is_binary(n), do: {:error, "Is not a integer."}

  def double(n) do
    n * 2
  end

  def greet(greeting, name) do
    fn
      ^name -> "#{greeting} #{name}"
      _ -> "I know you?"
    end
  end
end
