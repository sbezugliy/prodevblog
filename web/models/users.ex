defmodule Emporium.User do
  use Emporium.Web, :model

  require Ecto.Query

  alias Emporium.Repo
  alias Emporium.Role
  alias Emporium.UsersRoles

  schema "users" do
    field :name, :string
    field :email, :string

    many_to_many :roles, Role,
      join_through: UsersRoles,
      on_delete: :delete_all,
      on_replace: :delete

    has_many :authorizations, Emporium.Authorization
    timestamps
  end

  @required_fields ~w(name email)
  @optional_fields ~w()

  def registration_changeset(model, params \\ :empty) do
    model
    |>cast(params, ~w(email name), ~w())
  end

  @doc """
  Creates a changeset based on the `model` and `params`.
  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> Repo.preload(:roles)
    |> cast(params, [:name, :email])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
