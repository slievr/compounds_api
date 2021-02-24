defmodule CompoundsWeb.AssayResultControllerTest do
  use CompoundsWeb.ConnCase

  alias Compounds.Datasets
  alias Compounds.Datasets.AssayResult

  @create_attrs %{
    operator: "some operator",
    result: "some result",
    target: "some target",
    unit: "some unit",
    value: 42.0
  }
  @update_attrs %{
    operator: "some updated operator",
    result: "some updated result",
    target: "some updated target",
    unit: "some updated unit",
    value: 43.0
  }
  @invalid_attrs %{operator: nil, result: nil, target: nil, unit: nil, value: nil}

  def fixture(:assay_result) do
    {:ok, assay_result} = Datasets.create_assay_result(@create_attrs)
    assay_result
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all assay_results", %{conn: conn} do
      conn = get(conn, Routes.assay_result_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create assay_result" do
    test "renders assay_result when data is valid", %{conn: conn} do
      conn = post(conn, Routes.assay_result_path(conn, :create), assay_result: @create_attrs)
      assert %{"result_id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.assay_result_path(conn, :show, id))

      assert %{
               "result_id" => id,
               "operator" => "some operator",
               "result" => "some result",
               "target" => "some target",
               "unit" => "some unit",
               "value" => 42.0
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.assay_result_path(conn, :create), assay_result: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update assay_result" do
    setup [:create_assay_result]

    test "renders assay_result when data is valid", %{conn: conn, assay_result: %{id: id} = assay_result} do
      conn = put(conn, Routes.assay_result_path(conn, :update, assay_result), assay_result: @update_attrs)
      assert %{"result_id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.assay_result_path(conn, :show, id))

      assert %{
               "result_id" => id,
               "operator" => "some updated operator",
               "result" => "some updated result",
               "target" => "some updated target",
               "unit" => "some updated unit",
               "value" => 43.0
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, assay_result: assay_result} do
      conn = put(conn, Routes.assay_result_path(conn, :update, assay_result), assay_result: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete assay_result" do
    setup [:create_assay_result]

    test "deletes chosen assay_result", %{conn: conn, assay_result: assay_result} do
      conn = delete(conn, Routes.assay_result_path(conn, :delete, assay_result))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.assay_result_path(conn, :show, assay_result))
      end
    end
  end

  defp create_assay_result(_) do
    assay_result = fixture(:assay_result)
    %{assay_result: assay_result}
  end
end
