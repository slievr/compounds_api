defmodule Compounds.Datasets.Compound do
  use Ecto.Schema
  import Ecto.Changeset
  alias Compounds.Datasets.AssayResult

  schema "compounds" do
    field :alogp, :float
    field :image, :string
    field :molecular_formula, :string
    field :molecular_weight, :float
    field :num_rings, :integer
    field :smiles, :string

    has_many :assay_results, AssayResult, foreign_key: :compound_id

    timestamps()
  end

  @doc false
  def changeset(compound, attrs) do
    attrs = attrs
    |> normalise_keys()

    compound
    |> cast(attrs, [:id, :smiles, :molecular_weight, :alogp, :molecular_formula, :num_rings, :image])
    |> cast_assoc(:assay_results, with: &AssayResult.changeset/2)
    |> unique_constraint(:id, name: :compounds_pkey)
    |> validate_required([:smiles])
  end

  defp normalise_keys(attrs) do
    attrs
    |> Enum.map( fn {k,v} ->
      cond do
        k === "compound_id" -> { "id", v}
        true -> {String.downcase(k),v}
      end
    end)
    |> Enum.into(%{})
  end
end
