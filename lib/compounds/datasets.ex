defmodule Compounds.Datasets do
  @moduledoc """
  The Datasets context.
  """

  import Ecto.Query, warn: false
  alias Compounds.Repo

  alias Compounds.Datasets.Compound

  @doc """
  Returns the list of compounds.

  ## Examples

      iex> list_compounds()
      [%Compound{}, ...]

  """
  def list_compounds do
    Repo.all(Compound)
  end

  @doc """
  Gets a single compound.

  Raises `Ecto.NoResultsError` if the Compound does not exist.

  ## Examples

      iex> get_compound!(123)
      %Compound{}

      iex> get_compound!(456)
      ** (Ecto.NoResultsError)

  """
  def get_compound!(id), do: Repo.get!(Compound, id)

  @doc """
  Creates a compound.

  ## Examples

      iex> create_compound(%{field: value})
      {:ok, %Compound{}}

      iex> create_compound(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_compound(attrs \\ %{}) do
    %Compound{}
    |> Compound.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a compound.

  ## Examples

      iex> update_compound(compound, %{field: new_value})
      {:ok, %Compound{}}

      iex> update_compound(compound, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_compound(%Compound{} = compound, attrs) do
    compound
    |> Compound.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a compound.

  ## Examples

      iex> delete_compound(compound)
      {:ok, %Compound{}}

      iex> delete_compound(compound)
      {:error, %Ecto.Changeset{}}

  """
  def delete_compound(%Compound{} = compound) do
    Repo.delete(compound)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking compound changes.

  ## Examples

      iex> change_compound(compound)
      %Ecto.Changeset{data: %Compound{}}

  """
  def change_compound(%Compound{} = compound, attrs \\ %{}) do
    Compound.changeset(compound, attrs)
  end

  alias Compounds.Datasets.AssayResult

  @doc """
  Returns the list of assay_results.

  ## Examples

      iex> list_assay_results()
      [%AssayResult{}, ...]

  """
  def list_assay_results do
    Repo.all(AssayResult)
  end

  @doc """
  Gets a single assay_result.

  Raises `Ecto.NoResultsError` if the Assay result does not exist.

  ## Examples

      iex> get_assay_result!(123)
      %AssayResult{}

      iex> get_assay_result!(456)
      ** (Ecto.NoResultsError)

  """
  def get_assay_result!(id), do: Repo.get!(AssayResult, id)

  @doc """
  Creates a assay_result.

  ## Examples

      iex> create_assay_result(%{field: value})
      {:ok, %AssayResult{}}

      iex> create_assay_result(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assay_result(attrs \\ %{}) do
    %AssayResult{}
    |> AssayResult.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a assay_result.

  ## Examples

      iex> update_assay_result(assay_result, %{field: new_value})
      {:ok, %AssayResult{}}

      iex> update_assay_result(assay_result, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_assay_result(%AssayResult{} = assay_result, attrs) do
    assay_result
    |> AssayResult.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a assay_result.

  ## Examples

      iex> delete_assay_result(assay_result)
      {:ok, %AssayResult{}}

      iex> delete_assay_result(assay_result)
      {:error, %Ecto.Changeset{}}

  """
  def delete_assay_result(%AssayResult{} = assay_result) do
    Repo.delete(assay_result)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assay_result changes.

  ## Examples

      iex> change_assay_result(assay_result)
      %Ecto.Changeset{data: %AssayResult{}}

  """
  def change_assay_result(%AssayResult{} = assay_result, attrs \\ %{}) do
    AssayResult.changeset(assay_result, attrs)
  end
end
