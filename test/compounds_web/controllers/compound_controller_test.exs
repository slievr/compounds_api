defmodule CompoundsWeb.CompoundControllerTest do
  use CompoundsWeb.ConnCase

  alias Compounds.Datasets
  alias Compounds.Datasets.Compound

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

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
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.compound_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.compound_path(conn, :create), compound: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update compound" do
    setup [:create_compound]

    test "renders compound when data is valid", %{conn: conn, compound: %Compound{id: id} = compound} do
      conn = put(conn, Routes.compound_path(conn, :update, compound), compound: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.compound_path(conn, :show, id))

      assert %{
               "id" => id
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

  defp create_compound(_) do
    compound = fixture(:compound)
    %{compound: compound}
  end
end
