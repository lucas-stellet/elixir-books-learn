defmodule Stack.Server do
  use GenServer

  def init(initial_element), do: {:ok, [initial_element]}

  def handle_call({:push, new_element}, _from, current_stack) do
    {:reply, current_stack, Stack.push!(current_stack, new_element)}
  end

  def handle_call(:pop, _from, current_stack) do
    {:reply, current_stack, Stack.pop!(current_stack)}
  end

  def start(initial_element) do
    {:ok, pid} = GenServer.start_link(__MODULE__, initial_element)

    pid
  end

  def pop(pid), do: GenServer.call(pid, :pop)

  def push(pid, new_element), do: GenServer.call(pid, {:push, new_element})
end
