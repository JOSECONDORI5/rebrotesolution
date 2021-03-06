defmodule Smzr.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :is_active, :boolean, default: false
    field :password_hash, :string
    field :username, :string

    field :password, :string, virtual: true

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :is_active])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
      change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset) do
      changeset
  end
end
