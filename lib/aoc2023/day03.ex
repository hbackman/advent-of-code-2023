defmodule Aoc2023.Day03 do

  @symbols [
    "*", "=", "/", "%", "$",
    "#", "&", "-", "@", "+",
  ]

  defp format(input) do
    width = input
      |> String.split(~r/\R/)
      |> hd()
      |> String.length()

    input = Regex.replace(~r/\R/, input, "")
    match = Regex.scan(~r/\d+/, input, return: :index)
      |> Enum.map(&hd/1)
      |> Enum.map(fn {offset, length} -> {
        offset,
        length,
        input
          |> String.slice(offset, length)
          |> String.to_integer()
        }
      end)

    {input, width, match}
  end

  defp find_adjacent({input, width, parts}) do
    Enum.filter(parts, fn {offset, length, _number} ->
      Enum.to_list((offset-1-width)..(offset+length-width)) ++
      Enum.to_list((offset-1+width)..(offset+length+width)) ++
      [offset-1, offset+length]
        |> Enum.map(&String.slice(input, &1, 1))
        |> Enum.any?(&Enum.member?(@symbols, &1))
    end)
  end

  def part_one(input) do
    input
      |> format()
      |> find_adjacent()
      |> Enum.map(&elem(&1, 2))
      |> Enum.sum()
  end

  defp find_gears({input, width, parts}) do
    parts = Enum.filter(parts, fn {offset, length, _number} ->
      Enum.to_list((offset-1-width)..(offset+length-width)) ++
      Enum.to_list((offset-1+width)..(offset+length+width)) ++
      [offset-1, offset+length]
        |> Enum.map(&String.slice(input, &1, 1))
        |> Enum.any?(&(&1 == "*"))
    end)
  end

  def part_two(input) do
    input
      |> format()
      |> find_gears()
  end

end
