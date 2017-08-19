defmodule Emporium.UserController do
  use Emporium.Web, :controller

  alias Emporium.Role
  alias Emporium.User
  alias Emporium.UsersRoles

  plug EnsureAuthenticated, handler: __MODULE__, typ: "token"

  def index(conn, _params, current_user, _claims) do
    users = User |> Repo.all |> Repo.preload(:roles)

    render(conn, "index.html", users: users, current_user: current_user)
  end

  def resume(conn, _params, current_user, _claims) do
    #users = User |> Repo.all |> Repo.preload(:roles)

    render conn, "resume.html", current_user: current_user#, layout: {Emporium.LayoutView, "res.html"}
  end

  def manage(conn, %{"id" => id}, current_user, _claims) do
    user = User |> Repo.get!(id) |> Repo.preload(:roles)
    roles = Role |> Repo.all
    changeset = User.changeset(user)
    ur_changeset = UsersRoles.changeset(%UsersRoles{})
    render(conn, "manage.html", user: user, roles: roles, changeset: changeset, ur_changeset: ur_changeset, current_user: current_user)
  end

  def update(conn, %{"id" => id, "user" => user_params}, current_user, _claims) do
    user = User |> Repo.get!(id) |> Repo.preload(:roles)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :manage, user), current_user: current_user)
      {:error, changeset} ->
        render(conn, "manage.html", user: user, changeset: changeset, current_user: current_user)
    end
  end

  def insert_ur(conn, %{"id" => id, "users_roles" => ur_params}, current_user, _claims) do
    user = User |> Repo.get!(id) |> Repo.preload(:roles)
    role_dup = user.roles |> Enum.map(fn (role) -> role.id end) |> Enum.member?(ur_params["role_id"])
    if role_dup do
      conn
      |> put_flash(:error, "Role already assigned.")
      |> redirect(to: user_path(conn, :manage, user), current_user: current_user)
    else
      changeset = UsersRoles.changeset(%UsersRoles{}, %{user_id: user.id, role_id: ur_params["role_id"]})
      case Repo.insert(changeset) do
        {:ok, assoc} ->
          conn
          |> put_flash(:info, "User updated successfully.")
          |> redirect(to: user_path(conn, :manage, user), current_user: current_user)
        {:error, changeset} ->
          render(conn, "manage.html", user: user, changeset: changeset, current_user: current_user)
      end
    end
  end

  def delete_ur(conn, %{"id" => id, "role_id" => role_id}, current_user, _claims) do
    (from(ur in UsersRoles, where: [user_id: ^id, role_id: ^role_id])) |> Repo.delete_all
    conn
    |> redirect(to: user_path(conn, :manage, id), current_user: current_user)

  end

end
