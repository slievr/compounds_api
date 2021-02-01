defmodule Mix.Tasks.Compounds.SeedFromFile do
 use Mix.Task
 alias Compounds.{
   Datasets,
   Datasets.Compound
 }

  @shortdoc "Reads data from file to populate db"
  def run(args) do

    Mix.Task.run("app.start")

    IO.puts('-- starting --')

    {args, _, _} = OptionParser.parse(args, strict: [file: :string])

    file = args[:file]

    case File.exists?(file) do
      true -> load_data(file)
      false -> IO.puts("no file found.")
    end

    IO.puts('-- stopping --')
  end

  defp load_data(file_path) do
    read_json_file(file_path)
    |> insert_compound()
  end

  defp read_json_file(file_data) do
      file_data
    |> File.read!()
    |> String.replace("\r", "")
    |> String.replace("\n", "")
    |> String.replace("\t", "")
    |> Jason.decode!()
  end

  def insert_compound(compounds) when is_list(compounds) do
    compounds
    |> Enum.map(fn compound ->
      compound_json_to_struct(compound)
    end)
    |> IO.inspect()
  end

  def insert_compound(compound) do
    compound_json_to_struct(compound)
    |> IO.inspect()
  end

  def compound_json_to_struct(compound_json) do
    %Compound{}
    |> Compound.changeset(compound_json)
  end

end
