defmodule Weather.JSONParser do
  require Logger
  import Structs.StationDatum
  
  @derive [Poison.Encoder]
  
  def parse_station_list(json) do
    Logger.info "parsing station list"
    json = Poison.decode!(json, as: %{"results" => :results } )
    json["results"]
  end

  def parse_station_data(json) do
    Poison.decode!(json, as: %Structs.StationDatum{})
  end
end
