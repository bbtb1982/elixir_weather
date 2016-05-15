defmodule Weather.CLIOptions do
  @doc """
  Display help option menu
  """
  def help do 
    IO.puts """
    Help Option
    """
    System.halt(0);
  end
  
  @doc """
  List all known weather locations from `w1.weather.gov`
  """
  def list do
    IO.puts """
    List Option
    """
    System.halt(0);
  end
end
