defmodule Emporium.PackageControllerTest do
  use Emporium.ConnCase

  alias Emporium.Package
  @valid_attrs %{contain: "some content", description: "some content", fragile: true, height: "120.5", length: "120.5", number: "some content", price: "120.5", weight: "120.5", width: "120.5"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, package_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing packages"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, package_path(conn, :new)
    assert html_response(conn, 200) =~ "New package"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, package_path(conn, :create), package: @valid_attrs
    assert redirected_to(conn) == package_path(conn, :index)
    assert Repo.get_by(Package, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, package_path(conn, :create), package: @invalid_attrs
    assert html_response(conn, 200) =~ "New package"
  end

  test "shows chosen resource", %{conn: conn} do
    package = Repo.insert! %Package{}
    conn = get conn, package_path(conn, :show, package)
    assert html_response(conn, 200) =~ "Show package"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, package_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    package = Repo.insert! %Package{}
    conn = get conn, package_path(conn, :edit, package)
    assert html_response(conn, 200) =~ "Edit package"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    package = Repo.insert! %Package{}
    conn = put conn, package_path(conn, :update, package), package: @valid_attrs
    assert redirected_to(conn) == package_path(conn, :show, package)
    assert Repo.get_by(Package, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    package = Repo.insert! %Package{}
    conn = put conn, package_path(conn, :update, package), package: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit package"
  end

  test "deletes chosen resource", %{conn: conn} do
    package = Repo.insert! %Package{}
    conn = delete conn, package_path(conn, :delete, package)
    assert redirected_to(conn) == package_path(conn, :index)
    refute Repo.get(Package, package.id)
  end
end
