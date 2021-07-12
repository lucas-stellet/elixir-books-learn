defmodule Query do
  def return_people_list() do
    [
      %{name: "Grumpy", height: 1.24},
      %{name: "Dave", height: 1.88},
      %{name: "Dopey", height: 1.32},
      %{name: "Shaquille", height: 2.16},
      %{name: "Sneezy", height: 1.28}
    ]
  end

  def persons_higher_than(minimum_height) do
    for person = %{height: height} <- return_people_list(), height > minimum_height do
      person
    end
  end
end

# IO.inspect(for person = %{height: height} <- Query.return_people_list, height > 1.5, do: person)
