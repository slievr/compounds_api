defmodule Mix.Tasks.Compounds.SeedFromFile do
 use Mix.Task
 alias Compounds.{
   Datasets
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
    :ok <- validate_data(data) do
      insert_compounds(data)
    else
      {:error, error} -> IO.puts(Exception.message(error))
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
    |> Datasets.validate_compound_schema()

  end

  defp insert_compounds(compounds) when is_list(compounds) do
    compounds
    |> Datasets.upsert_compound()
    |> case do
      {:ok, _} -> IO.puts('#{length(compounds)} Compounds inserted')
    end
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
