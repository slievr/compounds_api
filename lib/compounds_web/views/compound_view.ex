defmodule CompoundsWeb.CompoundView do
  use CompoundsWeb, :view
  alias CompoundsWeb.CompoundView

  def render("index.json", %{compounds: compounds}) do
    %{data: render_many(compounds, CompoundView, "compound.json")}
  end

  def render("show.json", %{compound: compound}) do
    %{data: render_one(compound, CompoundView, "compound.json")}
  end

  def render("compound.json", %{compound: compound}) do
    %{id: compound.id}
  end
end
