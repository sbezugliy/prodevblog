defmodule Emporium.Role do
  use Emporium.Web, :model

  alias Emporium.Repo
  alias Emporium.User
  alias Emporium.UsersRoles

  schema "roles" do
    field :name, :string
    field :is_admin, :boolean, default: false

    many_to_many :users, User,
      join_through: UsersRoles,
      on_delete: :delete_all,
      on_replace: :delete

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :is_admin])
    |> validate_required([:name, :is_admin])
  end
end
