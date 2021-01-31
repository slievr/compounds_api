defmodule Compounds.Datasets.Compound do
  use Ecto.Schema
  import Ecto.Changeset

  schema "compounds" do

    timestamps()
  end

  @doc false
  def changeset(compound, attrs) do
    compound
    |> cast(attrs, [])
    |> validate_required([])
  end
end
