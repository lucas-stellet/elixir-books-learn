defmodule WorkingWithMultipleProcesses2 do
  def guard do
    receive do
      {:spidey, sender} ->
        send(sender, "Password accepted! You can pass!")

      {_, sender} ->
        send(sender, "Wrong answer! Step behind!")
    end
  end
end
