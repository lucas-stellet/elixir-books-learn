alias Sequence.Server

{:ok, pid } = GenServer.start_link(Server, 100)
