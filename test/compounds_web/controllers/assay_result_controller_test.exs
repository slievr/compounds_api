defmodule CompoundsWeb.AssayResultControllerTest do
  use CompoundsWeb.ConnCase

  alias Compounds.Datasets
  alias Compounds.Datasets.AssayResult

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

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
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.assay_result_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.assay_result_path(conn, :create), assay_result: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update assay_result" do
    setup [:create_assay_result]

    test "renders assay_result when data is valid", %{conn: conn, assay_result: %AssayResult{id: id} = assay_result} do
      conn = put(conn, Routes.assay_result_path(conn, :update, assay_result), assay_result: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.assay_result_path(conn, :show, id))

      assert %{
               "id" => id
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
