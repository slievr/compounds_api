defmodule Compounds.Datasets.AssayResult do
  use Ecto.Schema
  import Ecto.Changeset
  alias Compounds.Datasets.Compound

  schema "assay_results" do
    field :operator, :string
    field :result, :string
    field :target, :string
    field :unit, :string
    field :value, :float
    belongs_to :compound, Compound, references: :id

    timestamps()
  end

  @doc false
  def changeset(assay_result, attrs) do
    assay_result
    |> cast(attrs, [:id, :target, :result, :operator, :value, :unit])
    |> validate_required([:target, :result, :operator, :value, :unit])
  end

  def normalise_keys(attrs) do
    attrs
    |> Enum.map( fn {k,v} ->
      cond do
        k === "result_id" -> { "id", v}
        true -> {String.downcase(k),v}
      end
    end)
    |> Enum.into(%{})
  end
end
