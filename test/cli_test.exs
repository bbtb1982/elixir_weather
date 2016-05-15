defmodule CliTest do
  use ExUnit.Case

  import Weather.CLI, only: [   run: 1, 
                                parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",       "anything"]) == :help
    assert parse_args(["--help",   "anything"]) == :help
  end

  #  test ":list returned by option parsing with -l and --list options" do
  #    assert parse_args(["-l",        "anything"]) == :list
  #    assert parse_args(["--list",    "anything"]) == :list
  #   end

  test "three values retuned if three givin" do
    assert parse_args(["location"]) == { "location" }
  end

  test "acceptance test should return weather" do
    assert Weather.CLI.run(["COOP:010008"]) == { "stuff" }
  end
end

