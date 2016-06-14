defmodule CliTest do
  use ExUnit.Case

  import Weather.CLI, only: [   run: 1, 
                                parse_args: 1 ]

  ##############################
  # :help 
  ##############################
  # test ":help returned by option parsing with -h and --help options" do
  #   assert parse_args(["-h"]) == :help
  #   assert parse_args(["--help"]) == :help
  # end
  

  ##############################
  # :list 
  ##############################

  test ":list returned by option parsing and --list options" do
    assert parse_args(["--list"]) == :list
    assert parse_args(["--list", 100]) == {:list, 100}
    assert parse_args(["--list", "help"]) == :list_help
  end

  test "three values retuned if three givin" do
    assert parse_args(["location"]) == { "location" }
  end

  ##############################
  # fetch location datum 
  ##############################
  # test "acceptance test should return weather" do
  #   assert Weather.CLI.run(["COOP:010008"]) == { "stuff" }
  #  end

  ##############################
  # fetch a stations list
  ##############################
  test "should fetch all stations" do
    # assert Weather.CLI.run(["--list", 1000]) == true
    assert Weather.CLI.run(["--list"]) == true
  end
end

