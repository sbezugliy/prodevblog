defmodule Emporium.Part do
  use Emporium.Web, :model

  schema "parts" do
    field :name, :string
    field :short_link, :string
    field :content, :string
    field :published, :boolean, default: false
    belongs_to :author, Emporium.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :short_link, :content, :published])
    |> validate_required([:name, :published])
  end
end
