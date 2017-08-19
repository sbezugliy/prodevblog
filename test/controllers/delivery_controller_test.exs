defmodule Emporium.DeliveryControllerTest do
  use Emporium.ConnCase

  alias Emporium.Delivery
  @valid_attrs %{description: "some content", number: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, delivery_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing deliveries"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, delivery_path(conn, :new)
    assert html_response(conn, 200) =~ "New delivery"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, delivery_path(conn, :create), delivery: @valid_attrs
    assert redirected_to(conn) == delivery_path(conn, :index)
    assert Repo.get_by(Delivery, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, delivery_path(conn, :create), delivery: @invalid_attrs
    assert html_response(conn, 200) =~ "New delivery"
  end

  test "shows chosen resource", %{conn: conn} do
    delivery = Repo.insert! %Delivery{}
    conn = get conn, delivery_path(conn, :show, delivery)
    assert html_response(conn, 200) =~ "Show delivery"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, delivery_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    delivery = Repo.insert! %Delivery{}
    conn = get conn, delivery_path(conn, :edit, delivery)
    assert html_response(conn, 200) =~ "Edit delivery"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    delivery = Repo.insert! %Delivery{}
    conn = put conn, delivery_path(conn, :update, delivery), delivery: @valid_attrs
    assert redirected_to(conn) == delivery_path(conn, :show, delivery)
    assert Repo.get_by(Delivery, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    delivery = Repo.insert! %Delivery{}
    conn = put conn, delivery_path(conn, :update, delivery), delivery: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit delivery"
  end

  test "deletes chosen resource", %{conn: conn} do
    delivery = Repo.insert! %Delivery{}
    conn = delete conn, delivery_path(conn, :delete, delivery)
    assert redirected_to(conn) == delivery_path(conn, :index)
    refute Repo.get(Delivery, delivery.id)
  end
end
