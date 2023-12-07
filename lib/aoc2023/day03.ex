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

  defp neighbors(offset, length, width) do
    Enum.to_list((offset-1-width)..(offset+length-width)) ++
    Enum.to_list((offset-1+width)..(offset+length+width)) ++
    [offset-1, offset+length]
  end

  defp search_adjacent({input, width, parts}) do
    Enum.filter(parts, fn {offset, length, _number} ->
      neighbors(offset, length, width)
        |> Enum.map(&String.slice(input, &1, 1))
        |> Enum.any?(&Enum.member?(@symbols, &1))
    end)
  end

  def part_one(input) do
    input
      |> format()
      |> search_adjacent()
      |> Enum.map(&elem(&1, 2))
      |> Enum.sum()
  end

  defp search_gears({input, width, parts}) do
    indices = Regex.scan(~r/\*/, input, return: :index)
      |> Enum.map(&hd/1)
      |> Enum.map(&elem(&1, 0))

    Enum.map(indices, fn index ->
      neighbors(index, 1, width)
        |> Enum.map(fn pos ->
          Enum.find(parts, fn {o, l, _} -> pos in o..(o+l-1) end)
        end)
        |> Enum.uniq()
        |> Enum.filter(& &1)
    end)
  end

  def part_two(input) do
    input
      |> format()
      |> search_gears()
      |> Enum.filter(& length(&1) == 2)
      |> Enum.map(fn gears ->
        gears
          |> Enum.map(&elem(&1, 2))
          |> Enum.product()
      end)
      |> Enum.sum()
  end

end
