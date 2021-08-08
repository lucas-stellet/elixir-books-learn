defmodule Ticker do
  @name :tocker
  @interval 2000
  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts("registering #{inspect(pid)}")
        generator([pid | clients])
    after
      @interval ->
        IO.puts("tock")

        Enum.each(clients, fn client ->
          send(client, {:tick})
        end)

        generator(clients)
    end
  end

  def register(client_pid) do
    send(:global.whereis_name(@name), {:register, client_pid})
  end
end

defmodule Client do
  def start() do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts("tock in client")
        receiver()
    end
  end
end

defmodule Linker do
  def list_links() do
    case Node.list() do
      [] -> :no_connections
      list -> list
    end
  end

  def link(link_name) do
    {:ok, hostname} = :inet.gethostname()
    node = String.to_atom("#{link_name}@#{hostname}")

    case Node.connect(node) do
      true -> :connected
      false -> :not_found
    end
  end
end
