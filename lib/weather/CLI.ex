defmodule Weather.CLI do
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
    parse = OptionParser.parse(argv,  switchs: [help: :boolean, list: :boolean],
                                      aliases: [h: :help, l: :list])
    case parse do
      {[help: true], _, _} -> :help
      {[list: true], _, _} -> :list
      {_, [location], _} -> { location }
      _ -> :help 
    end
  end

  def process(:help), do: Weather.CLIOptions.help
  def process(:list), do: Weather.CLIOptions.list
  def process({location}) do
    Weather.WeatherService.fetch(location)
  end
  
end

