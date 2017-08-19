defmodule Emporium.PackageTest do
  use Emporium.ModelCase

  alias Emporium.Package

  @valid_attrs %{contain: "some content", description: "some content", fragile: true, height: "120.5", length: "120.5", number: "some content", price: "120.5", weight: "120.5", width: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Package.changeset(%Package{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Package.changeset(%Package{}, @invalid_attrs)
    refute changeset.valid?
  end
end
