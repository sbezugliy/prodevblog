defmodule Emporium.RoleController do
  use Emporium.Web, :controller

  alias Emporium.Role

  plug EnsureAuthenticated, handler: __MODULE__, typ: "token"

  def index(conn, _params, current_user, _claims) do
    roles = Repo.all(Role)
    render(conn, "index.html", roles: roles, current_user: current_user)
  end

  def new(conn, _params, current_user, _claims) do
    changeset = Role.changeset(%Role{})
    render(conn, "new.html", changeset: changeset, current_user: current_user)
  end

  def create(conn, %{"role" => role_params}, current_user, _claims) do
    changeset = Role.changeset(%Role{}, role_params)

    case Repo.insert(changeset) do
      {:ok, _role} ->
        conn
        |> put_flash(:info, "Role created successfully.")
        |> redirect(to: role_path(conn, :index), current_user: current_user)
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user)
    end
  end

  def show(conn, %{"id" => id}, current_user, _claims) do
    role = Repo.get!(Role, id)
    render(conn, "show.html", role: role, current_user: current_user)
  end

  def edit(conn, %{"id" => id}, current_user, _claims) do
    role = Repo.get!(Role, id)
    changeset = Role.changeset(role)
    render(conn, "edit.html", role: role, changeset: changeset, current_user: current_user)
  end

  def update(conn, %{"id" => id, "role" => role_params}, current_user, _claims) do
    role = Repo.get!(Role, id)
    changeset = Role.changeset(role, role_params)

    case Repo.update(changeset) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role updated successfully.")
        |> redirect(to: role_path(conn, :show, role), current_user: current_user)
      {:error, changeset} ->
        render(conn, "edit.html", role: role, changeset: changeset, current_user: current_user)
    end
  end

  def delete(conn, %{"id" => id}, current_user, _claims) do
    role = Repo.get!(Role, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(role)

    conn
    |> put_flash(:info, "Role deleted successfully.")
    |> redirect(to: role_path(conn, :index), current_user: current_user)
  end
end
