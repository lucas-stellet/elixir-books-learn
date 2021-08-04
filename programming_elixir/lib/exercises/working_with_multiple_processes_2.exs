defmodule Spawn do
  def create_processes(pid_list, 0), do: {:ok, pid_list}

  def create_processes(pid_list, n) do
    pid = spawn(Spawn, :spawned_function, [])

    create_processes(pid_list ++ [pid], n - 1)
  end

  def create_processes(n) do
    pid = spawn(Spawn, :spawned_function, [])

    create_processes([pid], n - 1)
  end

  def spawned_function() do
    receive do
      {sender, :aloha} ->
        # IO.inspect(sender)
        IO.puts("Meg received from PID #{inspect(sender)}")
        send(sender, {:aloha, "Aloha!"})
        spawned_function()
    end
  end

  def send_messages_to_pids([]), do: :ok

  def send_messages_to_pids([hd | tl]) do
    send(hd, {self(), :aloha})

    # IO.puts("msg sended!")

    receive do
      {:aloha, msg} ->
        IO.puts(msg)
    end

    send_messages_to_pids(tl)
  end
end

{:ok, pid_list} = Spawn.create_processes(6)

Spawn.send_messages_to_pids(pid_list)
