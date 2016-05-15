defmodule Weather.WeatherService do
  require Logger
  import Weather.JSONParser
  
  @weather_url Application.get_env(:weather, :weather_url)
  @ncdc_token Application.get_env(:weather, :ncdc_token)

  def fetch(location) do
    process_url(location)
    |> fetch_json 
    |> handle_response
    |> Weather.JSONParser.parse
  end

  def process_url(location) do
    Logger.info "url: #{@weather_url}/#{location}"  
    "#{@weather_url}#{location}"  
  end
  
  def fetch_json(url) do 
    Logger.info "fetching json from #{url}"
    HTTPoison.get(url, [{"token", "#{@ncdc_token}"}])
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Logger.info "Recieved http response status_code: 200"
    Logger.debug body
    { :ok, body }
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: 404, body: body}}) do
    Logger.info "Recieved http response status_code: 404"
    Logger.debug body
    { :error }
    System.halt(0)
  end
end
