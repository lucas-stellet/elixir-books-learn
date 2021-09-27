defmodule Metex do
  @moduledoc false

  alias Metex.{Coordinator, Worker}

  def temperature_of(cities) do
    coordinator_pid = spawn(Coordinator, :loop, [[], Enum.count(cities)])

    cities
    |> Enum.each(fn city ->
      worker_pid = spawn(Worker, :loop, [])
      send(worker_pid, {coordinator_pid, city})
    end)
  end
end
