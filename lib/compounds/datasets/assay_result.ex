defmodule Compounds.Datasets.AssayResult do
  use Ecto.Schema
  import Ecto.Changeset
  alias Compounds.Datasets.Compound

  schema "assay_results" do
    field :operator, :string
    field :result, :string
    field :target, :string
    field :unit, :string
    field :value, :integer
    belongs_to :compound, Compound, references: :compound_id

    timestamps()
  end

  @doc false
  def changeset(assay_result, attrs) do
    assay_result
    |> cast(attrs, [:target, :result, :operator, :value, :unit])
    |> validate_required([:target, :result, :operator, :value, :unit])
  end
end
