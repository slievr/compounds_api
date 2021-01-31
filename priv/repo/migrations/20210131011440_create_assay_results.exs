defmodule Compounds.Repo.Migrations.UpdateAssayResults do
  use Ecto.Migration

  def change do
    create table(:assay_results) do
      add :target, :string
      add :result, :string
      add :operator, :string
      add :value, :integer
      add :unit, :string
      add :compound_id, references(:compounds, column: :id)

      timestamps()
    end

  end
end
