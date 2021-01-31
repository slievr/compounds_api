defmodule Compounds.Repo.Migrations.CreateCompounds do
  use Ecto.Migration

  def change do
    alter table(:compounds) do
      add :smiles, :string
      add :molecular_weight, :float
      add :alogp, :string
      add :molecular_formula, :float
      add :num_rings, :float
      add :image, :string

    end

  end
end
