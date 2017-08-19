defmodule Emporium.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;")
    create table(:users) do
      add :name, :string
      add :email, :citext

      timestamps
    end

    create index(:users, [:email], unique: true)
  end
end
