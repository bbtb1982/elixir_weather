defmodule Weather.WeatherService do
  require Logger
  import Weather.JSONParser
  
  @weather_url Application.get_env(:weather, :weather_url)
  @ncdc_token Application.get_env(:weather, :ncdc_token)

  def fetch_station_data(location) do
    url = "#{@weather_url}#{location}"  
    url 
    |> fetch_json 
    |> handle_response
  end
 
  def fetch_stations(count) do
    url = "#{@weather_url}?limit=#{count}"  
    url 
    |> fetch_json
    |> handle_response
  end

  def fetch_json(url) do 
    Logger.info "fetching json from #{url}"
    HTTPoison.get(url, [{"token", "#{@ncdc_token}"}])
  end
 
  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Logger.info "Recieved http response status_code: 200"
    body
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 404}}) do
    Logger.info "Recieved http response status_code: 404"
    { :error }
    System.halt(0)
  end
  
  def handle_response({:error, %HTTPoison.Response{status_code: _, body: body}}) do
    Logger.info "response error #{body}"
  end
end
