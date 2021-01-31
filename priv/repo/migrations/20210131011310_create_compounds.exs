defmodule Compounds.Repo.Migrations.UpdateCompounds do
  use Ecto.Migration

  def change do
    create table(:compounds) do
      add :smiles, :string
      add :molecular_weight, :float
      add :alogp, :string
      add :molecular_formula, :float
      add :num_rings, :float
      add :image, :string

      timestamps()

    end

  end
end
