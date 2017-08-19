defmodule Emporium.UsersRoles do
  use Emporium.Web, :model

  require Ecto.Query
  alias Emporium.Repo

  alias Emporium.User
  alias Emporium.Role
  @primary_key false
  schema "users_roles" do
    belongs_to :user, User
    belongs_to :role, Role
    timestamps
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> Ecto.Changeset.cast(params, [:user_id, :role_id])
    |> Ecto.Changeset.validate_required([:user_id, :role_id])
    # Maybe do some counter caching here!
  end

end
