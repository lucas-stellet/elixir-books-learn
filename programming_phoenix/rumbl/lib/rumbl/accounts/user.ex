defmodule Rumbl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:name, :username]
  @required_fields @fields

  schema "users" do
    field :name, :string
    field :username, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> validate_length(:username, min: 1, max: 20)
  end
end
