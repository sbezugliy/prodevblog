defmodule Emporium.PartTest do
  use Emporium.ModelCase

  alias Emporium.Part

  @valid_attrs %{content: "some content", name: "some content", published: true, short_link: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Part.changeset(%Part{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Part.changeset(%Part{}, @invalid_attrs)
    refute changeset.valid?
  end
end
