defmodule Compounds.Repo.Migrations.CreateAssayResults do
  use Ecto.Migration

  def change do
    alter table(:assay_results) do
      add :target, :string
      add :result, :string
      add :operator, :string
      add :value, :integer
      add :unit, :string
      add :compound_id, references(:compounds)

    end

  end
end
