defmodule RumblWeb.UserView do
  use RumblWeb, :view

  alias Rumbl.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end

  def username(%Accounts.User{username: username}) do
    username
    |> String.downcase()
  end
end
