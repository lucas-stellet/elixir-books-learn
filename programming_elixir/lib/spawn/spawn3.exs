defmodule Spawn do
  def greet do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "Hello, #{msg}"})
        greet()
    end
  end
end

pid = spawn(Spawn, :greet, [])

send(pid, {self(), "World!"})

receive do
  {:ok, msg} -> IO.puts(msg)
end

send(pid, {self(), "Lucas!"})

receive do
  {:ok, msg} ->
    IO.puts(msg)
after
  500 -> IO.puts("The greeter has gone away!")
end
