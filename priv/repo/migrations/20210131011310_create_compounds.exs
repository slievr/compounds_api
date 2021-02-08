defmodule Compounds.Repo.Migrations.UpdateCompounds do
  use Ecto.Migration

  def change do
    create table(:compounds) do
      add :smiles, :string
      add :molecular_weight, :float
      add :alogp, :float
      add :molecular_formula, :string
      add :num_rings, :integer
      add :image, :string

      timestamps()

    end

  end
end
