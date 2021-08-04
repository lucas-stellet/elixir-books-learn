defmodule SpawnLink do
  import :timer, only: [sleep: 1]

  def child_function(parent_process) do
    send(parent_process, :im_done)
    exit(:died)
  end

  def run do
    current_process = self()
    spawn_link(SpawnLink, :child_function, [current_process])

    sleep(500)

    receive do
      msg ->
        IO.puts("Message received: #{inspect(msg)}")
    end
  end
end

SpawnLink.run()
