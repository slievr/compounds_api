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
    with data <- read_json_file(file_path),
    true <- validate_data(data) do
      insert_compound(data)
    else
      false -> IO.puts("invalid json")
    end
  end

  defp read_json_file(file_data) do
      file_data
    |> File.read!()
    |> String.replace("\r", "")
    |> String.replace("\n", "")
    |> String.replace("\t", "")
    |> remove_bom()
    |> Poison.decode!()
  end

  defp validate_data(compounds) do
    compounds
    |> Datasets.is_valid_compound_schema?()
  end

  defp insert_compound(compounds) do
    compounds
    |> Enum.map(&compound_json_to_struct/1)
    |> Datasets.upsert_compound()
  end

  defp compound_json_to_struct(compound_json) do
    %Compound{}
    |> Compound.changeset(compound_json)
  end

  defp remove_bom(string) do
    string |> String.replace("\uFEFF", "")
  end

  defp from_latin1(string) do
    :unicode.characters_to_binary(string, :latin1)
  end

  defp from_utf16(string) do
    :unicode.characters_to_binary(string, :utf16)
  end

  defp from_unicode(string) do
    :unicode.characters_to_binary(string, :unicode)
  end
end
