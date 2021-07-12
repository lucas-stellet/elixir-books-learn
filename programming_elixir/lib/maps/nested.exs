defmodule Customer do
  @moduledoc false
  defstruct name: "", company: ""

  def create_customer(name \\ "", company \\ "")
      when is_binary(name) and is_binary(company) do
    %Customer{
      name: name,
      company: company
    }
  end
end

defmodule BugReport do
  @moduledoc false
  defstruct owner: %Customer{}, details: "", severity: 1
end
