defmodule CompoundsWeb.AssayResultView do
  use CompoundsWeb, :view
  alias CompoundsWeb.AssayResultView

  def render("index.json", %{assay_results: assay_results}) do
    %{data: render_many(assay_results, AssayResultView, "assay_result.json")}
  end

  def render("show.json", %{assay_result: assay_result}) do
    %{data: render_one(assay_result, AssayResultView, "assay_result.json")}
  end

  def render("assay_result.json", %{assay_result: assay_result}) do
    %{id: assay_result.id}
  end
end
