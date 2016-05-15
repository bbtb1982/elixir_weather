defmodule Weather.JSONParser do
  require Logger
  import Structs.StationDatum

  @derive [Poison.Encoder]
  
  def parse({_, json}) do
    Logger.info "begin parsing json"
    Logger.debug json
    
    json  |> decode_json
          |> display
  end

  def decode_json(json) do
    Poison.decode!(json, as: %Structs.StationDatum{})
  end

  def display(datum) do
    IO.inspect datum.id
  end
end
