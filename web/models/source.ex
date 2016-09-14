defmodule UpcomingShowFinder.Source do
  use UpcomingShowFinder.Web, :model

  schema "sources" do
    field :venue_name, :string, null: false
    field :location, :string, null: false
    field :parser, :string, null: false
    field :url, :string, null: false
    field :enabled, :integer, default: 1

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:venue_name, :location, :parser, :url, :enabled])
    |> validate_required([:venue_name, :location, :parser, :url, :enabled])
    |> unique_constraint(:url)
  end
end
