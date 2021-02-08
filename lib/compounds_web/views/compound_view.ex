defmodule CompoundsWeb.CompoundView do
  use CompoundsWeb, :view

  alias CompoundsWeb.{
    CompoundView,
    AssayResultView
  }

  def render("index.json", %{compounds: compounds}) do
    %{data: render_many(compounds, CompoundView, "compound.json")}
  end

  def render("show.json", %{compound: compound}) do
    %{data: render_one(compound, CompoundView, "compound.json")}
  end

  def render("compound.json", %{compound: %{assay_results: assay_results} = compound})
      when is_list(assay_results) do
    compound |> IO.inspect()

    %{
      compound_id: compound.id,
      smiles: compound.smiles,
      molecular_weight: compound.molecular_weight,
      ALogP: compound.alogp,
      molecular_formula: compound.molecular_formula,
      num_rings: compound.num_rings,
      image: compound.image,
      assay_results: render_many(assay_results, AssayResultView, "assay_result.json")
    }
  end

  def render("compound.json", %{compound: compound}) do
    %{
      compound_id: compound.id,
      smiles: compound.smiles,
      molecular_weight: compound.molecular_weight,
      ALogP: compound.alogp,
      molecular_formula: compound.molecular_formula,
      num_rings: compound.num_rings,
      image: compound.image
    }
  end
end
