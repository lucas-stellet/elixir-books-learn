defmodule Parallel do
  import :timer, only: [sleep: 1]

  def pmap(collection, fun) do
    me = self()

    collection
    |> Enum.map(fn elem ->
      spawn_link(fn ->
        send(me, {self(), fun.(elem)})
      end)
    end)
    |> tap(&IO.inspect/1)
    |> Enum.map(fn pid ->
      sleep(500)

      receive do
        {^pid, result} -> result
      end
    end)
    |> tap(&IO.inspect/1)
  end
end

Parallel.pmap(1..15, &(&1 * &1))
