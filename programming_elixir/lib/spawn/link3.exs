defmodule Link do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep(500)
    exit(:boom)
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Link, :sad_function, [])

    receive do
      {_, pid, term} ->
        IO.puts("Process with PID '#{inspect(pid)}' finished with term '#{inspect(term)}'")
    after
      1000 ->
        IO.puts("Nothing happened as far as I am concerned")
    end
  end
end

Link.run()
