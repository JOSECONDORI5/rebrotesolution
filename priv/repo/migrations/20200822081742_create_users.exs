defmodule Smzr.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password_hash, :string
      add :is_active, :boolean, default: false, null: false

      timestamps()
    end

    create index(:users, :username, unique: true)

  end
end
