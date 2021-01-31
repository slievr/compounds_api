defmodule Compounds.Repo.Migrations.CreateAssayResults do
  use Ecto.Migration

  def change do
    create table(:assay_results) do

      timestamps()
    end

  end
end
