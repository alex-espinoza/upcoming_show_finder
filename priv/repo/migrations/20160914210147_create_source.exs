defmodule UpcomingShowFinder.Repo.Migrations.CreateSource do
  use Ecto.Migration

  def change do
    create table(:sources) do
      add :venue_name, :string
      add :location, :string
      add :parser, :string
      add :url, :string
      add :enabled, :integer

      timestamps()
    end

    create unique_index(:sources, [:url])
  end
end
