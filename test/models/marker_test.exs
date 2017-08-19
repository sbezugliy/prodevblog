defmodule Emporium.MarkerTest do
  use Emporium.ModelCase

  alias Emporium.Marker

  @valid_attrs %{address: "some content", lat: "120.5", lng: "120.5", name: "some content", type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Marker.changeset(%Marker{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Marker.changeset(%Marker{}, @invalid_attrs)
    refute changeset.valid?
  end
end
