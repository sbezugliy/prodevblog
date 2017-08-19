defmodule Emporium.Repo.Migrations.CreatePart do
  use Ecto.Migration

  def change do
    create table(:parts) do
      add :name, :string
      add :short_link, :string
      add :content, :text
      add :published, :boolean, default: false, null: false
      add :author_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:parts, [:author_id])

  end
end
