defmodule Ex do
  @author "Dave Thomas"

  def get_author do
    @author
  end
end

IO.puts("Example was written by #{Ex.get_author()}")
