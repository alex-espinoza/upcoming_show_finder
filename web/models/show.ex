defmodule UpcomingShowFinder.Show do
  use UpcomingShowFinder.Web, :model

  schema "shows" do
    field :headliner, :string, null: false
    field :openers, :string
    field :price, :string
    field :date, Ecto.DateTime, null: false
    belongs_to :source, UpcomingShowFinder.Source

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:headliner, :openers, :price, :date, :source_id])
    |> validate_required([:headliner, :date, :source_id])
  end
end
