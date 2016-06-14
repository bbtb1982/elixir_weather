defmodule Weather.CLI do
  require Logger
  import Weather.CLIOptions, only: [ help: 0, list: 0 ]
  import Weather.WeatherService 

  @default_location "KSLC"

  @moduledoc """
  Command line interface for fetching the wether by location
  """

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv,  strict: [help: :boolean, list: :boolean],
                                      aliases: [h: :help, l: :list])
    IO.inspect parse
    case parse do
      {[list: true], ["help"], _} -> :list_help
      {[list: true], [count], _} -> {:list, count}
      {[list: true], _, _} -> :list

      {[help: true], _, _} -> :help
      {_, [location], _} -> { location }
      _ -> :help 
    end
  end

  def process(:help), do: Weather.CLIOptions.help

  def process(:list_help),  do: Weather.CLIOptions.list

  def process({:list, count}) when is_integer(count), do: process_list(count)
  def process(:list), do: process_list

  def process({location}) do
    Weather.WeatherService.fetch_station_data(location)
  end
 
  def process_list(count \\50) do
    Weather.WeatherService.fetch_stations(count)
    |> Weather.JSONParser.parse_station_list
    |> Weather.WeatherDisplay.print_table_for_columns(["id", "name"])
  end
end

