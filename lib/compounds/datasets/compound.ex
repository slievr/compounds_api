defmodule Compounds.Datasets.Compound do
  use Ecto.Schema
  import Ecto.Changeset
  alias Compounds.Datasets.AssayResult

  schema "compounds" do
    field :alogp, :string
    field :image, :string
    field :molecular_formula, :float
    field :molecular_weight, :float
    field :num_rings, :float
    field :smiles, :string

    has_many :assay_results, AssayResult

    timestamps()
  end

  @doc false
  def changeset(compound, attrs) do
    compound
    |> cast(attrs, [:smiles, :molecular_weight, :alogp, :molecular_formula, :num_rings, :image])
    |> validate_required([:smiles, :molecular_weight, :alogp, :molecular_formula, :num_rings, :image])
  end
end
