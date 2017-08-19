defmodule Emporium.PartController do
  use Emporium.Web, :controller

  alias Emporium.Part

  plug EnsureAuthenticated, handler: __MODULE__, typ: "token"

  def index(conn, _params, current_user, _claims) do
    parts = Repo.all(Part)
    render(conn, "index.html", parts: parts, current_user: current_user)
  end

  def new(conn, _params, current_user, _claims) do
    changeset = Part.changeset(%Part{})
    render(conn, "new.html", changeset: changeset, current_user: current_user)
  end

  def create(conn, %{"part" => part_params}, current_user, _claims) do
    changeset = Part.changeset(%Part{}, part_params)

    case Repo.insert(changeset) do
      {:ok, _part} ->
        conn
        |> put_flash(:info, "Part created successfully.")
        |> redirect(to: part_path(conn, :index), current_user: current_user)
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, current_user: current_user)
    end
  end

  def show(conn, %{"id" => id}, current_user, _claims) do
    part = Repo.get!(Part, id)
    render(conn, "show.html", part: part, current_user: current_user)
  end

  def edit(conn, %{"id" => id}, current_user, _claims) do
    part = Repo.get!(Part, id)
    changeset = Part.changeset(part)
    render(conn, "edit.html", part: part, changeset: changeset, current_user: current_user)
  end

  def update(conn, %{"id" => id, "part" => part_params}, current_user, _claims) do
    part = Repo.get!(Part, id)
    changeset = Part.changeset(part, part_params)

    case Repo.update(changeset) do
      {:ok, part} ->
        conn
        |> put_flash(:info, "Part updated successfully.")
        |> redirect(to: part_path(conn, :show, part))
      {:error, changeset} ->
        render(conn, "edit.html", part: part, changeset: changeset, current_user: current_user)
    end
  end

  def delete(conn, %{"id" => id}, current_user, _claims) do
    part = Repo.get!(Part, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(part)

    conn
    |> put_flash(:info, "Part deleted successfully.")
    |> redirect(to: part_path(conn, :index), current_user: current_user)
  end
end
