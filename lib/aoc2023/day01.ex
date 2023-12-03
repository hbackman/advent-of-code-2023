defmodule Aoc2023.Day01 do

  defp parse(str) do
    s = String.replace(str, ~r/[a-zA-Z]/, "")
    f = String.slice(s,  0, 1)
    l = String.slice(s, -1, 1)
    String.to_integer(f <> l)
  end

  def part_one(input) do
    input
      |> String.split(~r/\R/)
      |> Enum.map(&parse/1)
      |> Enum.sum()
  end

  def part_two(input) do
    [
      {"oneight", "18"},
      {"twone", "21"},
      {"threeight", "38"},
      {"fiveight", "58"},
      {"sevenine", "79"},
      {"eightwo", "82"},
      {"eighthree", "83"},
      {"nineight", "98"},
      {"one", "1"},
      {"two", "2"},
      {"three", "3"},
      {"four", "4"},
      {"five", "5"},
      {"six", "6"},
      {"seven", "7"},
      {"eight", "8"},
      {"nine", "9"},
    ] |> Enum.reduce(input, fn {l, r}, c -> String.replace(c, l, r) end)
      |> String.split(~r/\R/)
      |> Enum.map(&parse/1)
      |> Enum.sum()
  end

end
