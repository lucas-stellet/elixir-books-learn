defmodule Spawn4 do
  def greet do
    receive do
      {sender, msg} ->
        send(sender, {:ok, "Hello, #{msg}"})
        greet()
    end
  end

  def greeter do
    pid = spawn(Spawn4, :greet, [])
    send(pid, {self(), "World!"})

    receive do
      {:ok, msg} -> IO.puts(msg)
    end

    send(pid, {self(), "Kermit!"})

    receive do
      {:ok, msg} -> IO.puts(msg)
    after
      1 -> IO.puts("The greeter has gone away")
    end
  end
end
