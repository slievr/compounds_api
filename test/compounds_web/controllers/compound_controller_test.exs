defmodule CompoundsWeb.CompoundControllerTest do
  use CompoundsWeb.ConnCase

  alias Compounds.Datasets
  alias Compounds.Datasets.Compound

  @create_attrs %{
    alogp: 12.1,
    image: "some image",
    molecular_formula: "some formulae",
    molecular_weight: 120.5,
    num_rings: 120,
    smiles: "some smiles"
  }
  @update_attrs %{
    alogp: 12.4,
    image: "some updated image",
    molecular_formula: "updated formulae",
    molecular_weight: 456.7,
    num_rings: 456,
    smiles: "some updated smiles"
  }

  @invalid_attrs %{
    alogp: nil,
    image: nil,
    molecular_formula: nil,
    molecular_weight: nil,
    num_rings: nil,
    smiles: nil
  }

  @invalid_json """
  [
    {
      "compound_id": "test1",
      "smiles": "Cc1nnc2[C@H](NC(=O)OCc3ccccc3)N=C(c4ccccc4)c5ccccc5n12",
      "molecular_weight": 423.46654,
      "ALogP": 4.686,
      "molecular_formula": "C25H21N5O2",
      "num_rings": 5,
      "image": "images/1117973.png",
      "assay_results": [
        {
          "result_id": "test1",
          "target": "Bromodomain-containing protein 4",
          "result": "IC50",
          "operator": "=",
          "value": 15.5,
          "unit": "nM"
        },
        {
          "result_id": "test5",
          "target": "Bromodomain-containing protein 4",
          "result": "IC50",
          "operator": "=",
          "value": 140,
          "unit": "nM"
        }
      ]
    },
    {
      "compound_id": "test2",
      "smiles": "CCNC(=O)C[C@@H]1N=C(c2ccc(Cl)cc2)c3cc(OC)ccc3n4c(C)nnc14",
      "molecular_weight": 423.89538,
      "ALogP": 3.288,
      "molecular_formula": "C22H22ClN5O2",
      "num_rings": 4,
      "image": "images/694811.png",
      "assay_results": [
        {
          "result_id": "test2",
          "target": "Bromodomain-containing protein 4",
          "result": "IC50",
          "operator": "=",
          "value": 36.1,
          "unit": "nM"
        }
      ]
    }
  ]
  """


  @valid_json """
  [
    {
      "compound_id": 1117973,
      "smiles": "Cc1nnc2[C@H](NC(=O)OCc3ccccc3)N=C(c4ccccc4)c5ccccc5n12",
      "molecular_weight": 423.46654,
      "ALogP": 4.686,
      "molecular_formula": "C25H21N5O2",
      "num_rings": 5,
      "image": "images/1117973.png",
      "assay_results": [
        {
          "result_id": 8046397,
          "target": "Bromodomain-containing protein 4",
          "result": "IC50",
          "operator": "=",
          "value": 15.5,
          "unit": "nM"
        }
      ]
    },
    {
      "compound_id": 694811,
      "smiles": "CCNC(=O)C[C@@H]1N=C(c2ccc(Cl)cc2)c3cc(OC)ccc3n4c(C)nnc14",
      "molecular_weight": 423.89538,
      "ALogP": 3.288,
      "molecular_formula": "C22H22ClN5O2",
      "num_rings": 4,
      "image": "images/694811.png",
      "assay_results": [
        {
          "result_id": 8046403,
          "target": "Bromodomain-containing protein 4",
          "result": "IC50",
          "operator": "=",
          "value": 36.1,
          "unit": "nM"
        }
      ]
    }
  ]
  """

  def fixture(:compound) do
    {:ok, compound} = Datasets.create_compound(@create_attrs)
    compound
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all compounds", %{conn: conn} do
      conn = get(conn, Routes.compound_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create compound" do
    test "renders compound when data is valid", %{conn: conn} do
      conn = post(conn, Routes.compound_path(conn, :create), compound: @create_attrs)
      assert %{"compound_id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.compound_path(conn, :show, id))

      assert %{
               "compound_id" => id,
               "ALogP" => 12.1,
               "image" => "some image",
               "molecular_formula" => "some formulae",
               "molecular_weight" => 120.5,
               "num_rings" => 120,
               "smiles" => "some smiles"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.compound_path(conn, :create), compound: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update compound" do
    setup [:create_compound]

    test "renders compound when data is valid", %{
      conn: conn,
      compound: %Compound{id: id} = compound
    } do
      conn = put(conn, Routes.compound_path(conn, :update, compound), compound: @update_attrs)
      assert %{"compound_id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.compound_path(conn, :show, id))

      assert %{
               "compound_id" => id,
               "ALogP" => 12.4,
               "image" => "some updated image",
               "molecular_formula" => "updated formulae",
               "molecular_weight" => 456.7,
               "num_rings" => 456,
               "smiles" => "some updated smiles"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, compound: compound} do
      conn = put(conn, Routes.compound_path(conn, :update, compound), compound: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete compound" do
    setup [:create_compound]

    test "deletes chosen compound", %{conn: conn, compound: compound} do
      conn = delete(conn, Routes.compound_path(conn, :delete, compound))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.compound_path(conn, :show, compound))
      end
    end
  end

  describe "bulk" do
    test "invalid json document returns error", %{conn: conn} do
      conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> put(Routes.compound_path(conn, :bulk_upsert), @invalid_json)

      assert response(conn, 400)
    end

    test "valid json document creates compounds", %{conn: conn} do

      conn =
        conn
        |> put_req_header("content-type", "application/json")
        |> put(Routes.compound_path(conn, :bulk_upsert), @valid_json)

      assert response(conn, :no_content)
    end
  end

  defp create_compound(_) do
    compound = fixture(:compound)
    %{compound: compound}
  end
end
