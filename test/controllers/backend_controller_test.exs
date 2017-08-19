defmodule Emporium.BackendControllerTest do
  use Emporium.ConnCase

  alias Emporium.Backend
  @valid_attrs %{}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, backend_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing backend"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, backend_path(conn, :new)
    assert html_response(conn, 200) =~ "New backend"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, backend_path(conn, :create), backend: @valid_attrs
    assert redirected_to(conn) == backend_path(conn, :index)
    assert Repo.get_by(Backend, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, backend_path(conn, :create), backend: @invalid_attrs
    assert html_response(conn, 200) =~ "New backend"
  end

  test "shows chosen resource", %{conn: conn} do
    backend = Repo.insert! %Backend{}
    conn = get conn, backend_path(conn, :show, backend)
    assert html_response(conn, 200) =~ "Show backend"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, backend_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    backend = Repo.insert! %Backend{}
    conn = get conn, backend_path(conn, :edit, backend)
    assert html_response(conn, 200) =~ "Edit backend"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    backend = Repo.insert! %Backend{}
    conn = put conn, backend_path(conn, :update, backend), backend: @valid_attrs
    assert redirected_to(conn) == backend_path(conn, :show, backend)
    assert Repo.get_by(Backend, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    backend = Repo.insert! %Backend{}
    conn = put conn, backend_path(conn, :update, backend), backend: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit backend"
  end

  test "deletes chosen resource", %{conn: conn} do
    backend = Repo.insert! %Backend{}
    conn = delete conn, backend_path(conn, :delete, backend)
    assert redirected_to(conn) == backend_path(conn, :index)
    refute Repo.get(Backend, backend.id)
  end
end
