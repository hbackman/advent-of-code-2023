defmodule Aoc2023.Day02 do

  defp parse(line) do
    [id | cubes] = line
      |> String.replace("Game ", "")
      |> String.split([":", ";"])

    cubes = Enum.map(cubes, fn cubes ->
      Regex.scan(~r/(\d+)\ (\w+)/, cubes, capture: :all_but_first)
        |> Enum.map(fn [count, color] ->
          {
            String.to_integer(count),
            String.to_atom(color),
          }
        end)
    end)

    {String.to_integer(id), cubes}
  end

  defp possible?({_, sets}) do
    flat = List.flatten(sets)

    max_r = max_by_color(flat, :red)
    max_g = max_by_color(flat, :green)
    max_b = max_by_color(flat, :blue)

    total = sets
      |> Enum.map(fn turn ->
        turn
          |> Enum.map(&elem(&1, 0))
          |> Enum.sum()
      end)
      |> Enum.max()

    total <= 39 && max_r <= 12 && max_g <= 13 && max_b <= 14
  end

  defp max_by_color(cubes, color) do
    cubes
      |> Enum.filter(fn {_, c} -> c == color end)
      |> Enum.map(&elem(&1, 0))
      |> Enum.max()
  end

  def part_one(input) do
    input
      |> String.split(~r/\R/)
      |> Enum.map(&parse/1)
      |> Enum.filter(&possible?/1)
      |> Enum.map(&elem(&1, 0))
      |> Enum.sum()
  end

  defp power({_, sets}) do
    flat = List.flatten(sets)

    max_r = max_by_color(flat, :red)
    max_g = max_by_color(flat, :green)
    max_b = max_by_color(flat, :blue)

    max_r * max_g * max_b
  end

  def part_two(input) do
    input
      |> String.split(~r/\R/)
      |> Enum.map(&parse/1)
      |> Enum.map(&power/1)
      |> Enum.sum()
  end

end
