defmodule UpcomingShowFinder.Repo.Migrations.CreateShow do
  use Ecto.Migration

  def change do
    create table(:shows) do
      add :headliner, :string
      add :openers, :string
      add :price, :string
      add :date, :datetime
      add :source_id, references(:sources, on_delete: :nilify_all)

      timestamps()
    end

    create index(:shows, [:source_id])
  end
end
