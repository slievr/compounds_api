defmodule Compounds.Datasets.AssayResult do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assay_results" do

    timestamps()
  end

  @doc false
  def changeset(assay_result, attrs) do
    assay_result
    |> cast(attrs, [])
    |> validate_required([])
  end
end
