defmodule Emporium.MarkerControllerTest do
  use Emporium.ConnCase

  alias Emporium.Marker
  @valid_attrs %{address: "some content", lat: "120.5", lng: "120.5", name: "some content", type: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, marker_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing markers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, marker_path(conn, :new)
    assert html_response(conn, 200) =~ "New marker"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, marker_path(conn, :create), marker: @valid_attrs
    assert redirected_to(conn) == marker_path(conn, :index)
    assert Repo.get_by(Marker, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, marker_path(conn, :create), marker: @invalid_attrs
    assert html_response(conn, 200) =~ "New marker"
  end

  test "shows chosen resource", %{conn: conn} do
    marker = Repo.insert! %Marker{}
    conn = get conn, marker_path(conn, :show, marker)
    assert html_response(conn, 200) =~ "Show marker"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, marker_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    marker = Repo.insert! %Marker{}
    conn = get conn, marker_path(conn, :edit, marker)
    assert html_response(conn, 200) =~ "Edit marker"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    marker = Repo.insert! %Marker{}
    conn = put conn, marker_path(conn, :update, marker), marker: @valid_attrs
    assert redirected_to(conn) == marker_path(conn, :show, marker)
    assert Repo.get_by(Marker, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    marker = Repo.insert! %Marker{}
    conn = put conn, marker_path(conn, :update, marker), marker: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit marker"
  end

  test "deletes chosen resource", %{conn: conn} do
    marker = Repo.insert! %Marker{}
    conn = delete conn, marker_path(conn, :delete, marker)
    assert redirected_to(conn) == marker_path(conn, :index)
    refute Repo.get(Marker, marker.id)
  end
end
