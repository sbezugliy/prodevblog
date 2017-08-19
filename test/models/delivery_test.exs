defmodule Emporium.DeliveryTest do
  use Emporium.ModelCase

  alias Emporium.Delivery

  @valid_attrs %{description: "some content", number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Delivery.changeset(%Delivery{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Delivery.changeset(%Delivery{}, @invalid_attrs)
    refute changeset.valid?
  end
end
