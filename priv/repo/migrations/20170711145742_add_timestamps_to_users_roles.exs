defmodule Emporium.Repo.Migrations.AddTimestampsToUsersRoles do
  use Ecto.Migration

  def change do
    alter table(:users_roles) do
      timestamps()
    end
  end
end
