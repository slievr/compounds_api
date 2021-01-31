defmodule Compounds.DatasetsTest do
  use Compounds.DataCase

  alias Compounds.Datasets

  describe "compounds" do
    alias Compounds.Datasets.Compound

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def compound_fixture(attrs \\ %{}) do
      {:ok, compound} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Datasets.create_compound()

      compound
    end

    test "list_compounds/0 returns all compounds" do
      compound = compound_fixture()
      assert Datasets.list_compounds() == [compound]
    end

    test "get_compound!/1 returns the compound with given id" do
      compound = compound_fixture()
      assert Datasets.get_compound!(compound.id) == compound
    end

    test "create_compound/1 with valid data creates a compound" do
      assert {:ok, %Compound{} = compound} = Datasets.create_compound(@valid_attrs)
    end

    test "create_compound/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Datasets.create_compound(@invalid_attrs)
    end

    test "update_compound/2 with valid data updates the compound" do
      compound = compound_fixture()
      assert {:ok, %Compound{} = compound} = Datasets.update_compound(compound, @update_attrs)
    end

    test "update_compound/2 with invalid data returns error changeset" do
      compound = compound_fixture()
      assert {:error, %Ecto.Changeset{}} = Datasets.update_compound(compound, @invalid_attrs)
      assert compound == Datasets.get_compound!(compound.id)
    end

    test "delete_compound/1 deletes the compound" do
      compound = compound_fixture()
      assert {:ok, %Compound{}} = Datasets.delete_compound(compound)
      assert_raise Ecto.NoResultsError, fn -> Datasets.get_compound!(compound.id) end
    end

    test "change_compound/1 returns a compound changeset" do
      compound = compound_fixture()
      assert %Ecto.Changeset{} = Datasets.change_compound(compound)
    end
  end

  describe "assay_results" do
    alias Compounds.Datasets.AssayResult

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def assay_result_fixture(attrs \\ %{}) do
      {:ok, assay_result} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Datasets.create_assay_result()

      assay_result
    end

    test "list_assay_results/0 returns all assay_results" do
      assay_result = assay_result_fixture()
      assert Datasets.list_assay_results() == [assay_result]
    end

    test "get_assay_result!/1 returns the assay_result with given id" do
      assay_result = assay_result_fixture()
      assert Datasets.get_assay_result!(assay_result.id) == assay_result
    end

    test "create_assay_result/1 with valid data creates a assay_result" do
      assert {:ok, %AssayResult{} = assay_result} = Datasets.create_assay_result(@valid_attrs)
    end

    test "create_assay_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Datasets.create_assay_result(@invalid_attrs)
    end

    test "update_assay_result/2 with valid data updates the assay_result" do
      assay_result = assay_result_fixture()
      assert {:ok, %AssayResult{} = assay_result} = Datasets.update_assay_result(assay_result, @update_attrs)
    end

    test "update_assay_result/2 with invalid data returns error changeset" do
      assay_result = assay_result_fixture()
      assert {:error, %Ecto.Changeset{}} = Datasets.update_assay_result(assay_result, @invalid_attrs)
      assert assay_result == Datasets.get_assay_result!(assay_result.id)
    end

    test "delete_assay_result/1 deletes the assay_result" do
      assay_result = assay_result_fixture()
      assert {:ok, %AssayResult{}} = Datasets.delete_assay_result(assay_result)
      assert_raise Ecto.NoResultsError, fn -> Datasets.get_assay_result!(assay_result.id) end
    end

    test "change_assay_result/1 returns a assay_result changeset" do
      assay_result = assay_result_fixture()
      assert %Ecto.Changeset{} = Datasets.change_assay_result(assay_result)
    end
  end

  describe "compounds" do
    alias Compounds.Datasets.Compound

    @valid_attrs %{ALogP: "some ALogP", image: "some image", molecular_formula: 120.5, molecular_weight: 120.5, num_rings: 120.5, smiles: "some smiles"}
    @update_attrs %{ALogP: "some updated ALogP", image: "some updated image", molecular_formula: 456.7, molecular_weight: 456.7, num_rings: 456.7, smiles: "some updated smiles"}
    @invalid_attrs %{ALogP: nil, image: nil, molecular_formula: nil, molecular_weight: nil, num_rings: nil, smiles: nil}

    def compound_fixture(attrs \\ %{}) do
      {:ok, compound} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Datasets.create_compound()

      compound
    end

    test "list_compounds/0 returns all compounds" do
      compound = compound_fixture()
      assert Datasets.list_compounds() == [compound]
    end

    test "get_compound!/1 returns the compound with given id" do
      compound = compound_fixture()
      assert Datasets.get_compound!(compound.id) == compound
    end

    test "create_compound/1 with valid data creates a compound" do
      assert {:ok, %Compound{} = compound} = Datasets.create_compound(@valid_attrs)
      assert compound.ALogP == "some ALogP"
      assert compound.image == "some image"
      assert compound.molecular_formula == 120.5
      assert compound.molecular_weight == 120.5
      assert compound.num_rings == 120.5
      assert compound.smiles == "some smiles"
    end

    test "create_compound/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Datasets.create_compound(@invalid_attrs)
    end

    test "update_compound/2 with valid data updates the compound" do
      compound = compound_fixture()
      assert {:ok, %Compound{} = compound} = Datasets.update_compound(compound, @update_attrs)
      assert compound.ALogP == "some updated ALogP"
      assert compound.image == "some updated image"
      assert compound.molecular_formula == 456.7
      assert compound.molecular_weight == 456.7
      assert compound.num_rings == 456.7
      assert compound.smiles == "some updated smiles"
    end

    test "update_compound/2 with invalid data returns error changeset" do
      compound = compound_fixture()
      assert {:error, %Ecto.Changeset{}} = Datasets.update_compound(compound, @invalid_attrs)
      assert compound == Datasets.get_compound!(compound.id)
    end

    test "delete_compound/1 deletes the compound" do
      compound = compound_fixture()
      assert {:ok, %Compound{}} = Datasets.delete_compound(compound)
      assert_raise Ecto.NoResultsError, fn -> Datasets.get_compound!(compound.id) end
    end

    test "change_compound/1 returns a compound changeset" do
      compound = compound_fixture()
      assert %Ecto.Changeset{} = Datasets.change_compound(compound)
    end
  end

  describe "assay_results" do
    alias Compounds.Datasets.AssayResult

    @valid_attrs %{operator: "some operator", result: "some result", target: "some target", unit: "some unit", value: 42}
    @update_attrs %{operator: "some updated operator", result: "some updated result", target: "some updated target", unit: "some updated unit", value: 43}
    @invalid_attrs %{operator: nil, result: nil, target: nil, unit: nil, value: nil}

    def assay_result_fixture(attrs \\ %{}) do
      {:ok, assay_result} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Datasets.create_assay_result()

      assay_result
    end

    test "list_assay_results/0 returns all assay_results" do
      assay_result = assay_result_fixture()
      assert Datasets.list_assay_results() == [assay_result]
    end

    test "get_assay_result!/1 returns the assay_result with given id" do
      assay_result = assay_result_fixture()
      assert Datasets.get_assay_result!(assay_result.id) == assay_result
    end

    test "create_assay_result/1 with valid data creates a assay_result" do
      assert {:ok, %AssayResult{} = assay_result} = Datasets.create_assay_result(@valid_attrs)
      assert assay_result.operator == "some operator"
      assert assay_result.result == "some result"
      assert assay_result.target == "some target"
      assert assay_result.unit == "some unit"
      assert assay_result.value == 42
    end

    test "create_assay_result/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Datasets.create_assay_result(@invalid_attrs)
    end

    test "update_assay_result/2 with valid data updates the assay_result" do
      assay_result = assay_result_fixture()
      assert {:ok, %AssayResult{} = assay_result} = Datasets.update_assay_result(assay_result, @update_attrs)
      assert assay_result.operator == "some updated operator"
      assert assay_result.result == "some updated result"
      assert assay_result.target == "some updated target"
      assert assay_result.unit == "some updated unit"
      assert assay_result.value == 43
    end

    test "update_assay_result/2 with invalid data returns error changeset" do
      assay_result = assay_result_fixture()
      assert {:error, %Ecto.Changeset{}} = Datasets.update_assay_result(assay_result, @invalid_attrs)
      assert assay_result == Datasets.get_assay_result!(assay_result.id)
    end

    test "delete_assay_result/1 deletes the assay_result" do
      assay_result = assay_result_fixture()
      assert {:ok, %AssayResult{}} = Datasets.delete_assay_result(assay_result)
      assert_raise Ecto.NoResultsError, fn -> Datasets.get_assay_result!(assay_result.id) end
    end

    test "change_assay_result/1 returns a assay_result changeset" do
      assay_result = assay_result_fixture()
      assert %Ecto.Changeset{} = Datasets.change_assay_result(assay_result)
    end
  end
end
