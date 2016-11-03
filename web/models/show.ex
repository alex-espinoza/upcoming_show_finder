defmodule UpcomingShowFinder.Show do
  use UpcomingShowFinder.Web, :model

  schema "shows" do
    field :headliner, :string, null: false
    field :openers, :string
    field :price, :string
    field :date, Ecto.DateTime, null: false
    field :information_url, :string
    field :ticket_url, :string
    belongs_to :source, UpcomingShowFinder.Source

    timestamps()
  end

  @doc """
  Builds a changeset based on the `model` and `params`.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:headliner, :openers, :price, :date, :information_url, :ticket_url, :source_id])
    |> validate_required([:headliner, :date, :source_id])
    |> unique_constraint(:headliner, name: :headliner_date_source_id_index)
  end
end
