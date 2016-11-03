defmodule UpcomingShowFinder.Repo.Migrations.CreateShow do
  use Ecto.Migration

  def change do
    create table(:shows) do
      add :headliner, :string
      add :openers, :string
      add :price, :string
      add :date, :datetime
      add :information_url, :string
      add :ticket_url, :string
      add :source_id, references(:sources, on_delete: :nilify_all)

      timestamps()
    end

    create index(:shows, [:source_id])
    create unique_index(:shows, [:headliner, :date, :source_id], name: :headliner_date_source_id_index)
  end
end
