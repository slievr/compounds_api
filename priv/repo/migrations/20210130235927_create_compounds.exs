defmodule Compounds.Repo.Migrations.CreateCompounds do
  use Ecto.Migration

  def change do
    create table(:compounds) do

      timestamps()
    end

  end
end
