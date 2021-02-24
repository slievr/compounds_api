defmodule CompoundsWeb.CompoundController do
  use CompoundsWeb, :controller

  alias Compounds.Datasets
  alias Compounds.Datasets.Compound

  action_fallback CompoundsWeb.FallbackController

  def index(conn, _params) do
    compounds = Datasets.list_compounds()
    render(conn, "index.json", compounds: compounds)
  end

  def create(conn, %{"compound" => compound_params}) do
    with {:ok, %Compound{} = compound} <- Datasets.create_compound(compound_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.compound_path(conn, :show, compound))
      |> render("show.json", compound: compound)
    end
  end

  def show(conn, %{"id" => id}) do
    compound = Datasets.get_compound!(id)
    render(conn, "show.json", compound: compound)
  end

  def update(conn, %{"id" => id, "compound" => compound_params}) do
    compound = Datasets.get_compound!(id)

    with {:ok, %Compound{} = compound} <- Datasets.update_compound(compound, compound_params) do
      render(conn, "show.json", compound: compound)
    end
  end

  def bulk_upsert(conn, %{"_json" => [%{} | _rest] = compounds}) when is_list(compounds) do
    with :ok <- Datasets.validate_compound_schema(compounds),
    {:ok, _res} <- Datasets.upsert_compound(compounds) do
      send_resp(conn, :no_content, "")
    else
      {:error, %JsonXema.ValidationError{} = error} -> send_resp(conn, 400, Exception.message(error))
      {:error, error} -> send_resp(conn, 409, error)
    end
  end

  def delete(conn, %{"id" => id}) do
    compound = Datasets.get_compound!(id)

    with {:ok, %Compound{}} <- Datasets.delete_compound(compound) do
      send_resp(conn, :no_content, "")
    end
  end
end
