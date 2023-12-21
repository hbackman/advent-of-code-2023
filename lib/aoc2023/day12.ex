defmodule Aoc2023.Day12 do

  defp format(input) do
    input
      |> Util.string_split_lines()
      |> Enum.map(fn line ->
        [fmt1, fmt2] = String.split(line, " ")
        {fmt1, fmt2 |> Util.string_to_int_list(",")}
      end)
  end

  defp fill("", string),
    do: string

  defp fill("?" <> rest, string) do
    [
      fill(rest, string <> "."),
      fill(rest, string <> "#"),
    ]
  end

  defp fill("#" <> rest, string), do: fill(rest, string <> "#")
  defp fill("." <> rest, string), do: fill(rest, string <> ".")

  defp valid?("", _, [0]), do: true
  defp valid?("", _, [ ]), do: true
  defp valid?("", _, _),   do: false

  defp valid?("#" <> _, _, [0 | _]), do: false
  defp valid?("#" <> _, _, []),      do: false

  defp valid?("." <> rest, ".", [h | t]),
    do: valid?(rest, ".", [h | t])

  defp valid?("." <> rest, ".", []),
    do: valid?(rest, ".", [])

  defp valid?("." <> rest, "#", [0 | t]),
    do: valid?(rest, ".", t)

  defp valid?("." <> _, "#", [_ | _]),
    do: false

  defp valid?("#" <> rest, _, [h | t]),
    do: valid?(rest, "#", [h-1 | t])

  def part_one(input) do
    input
      |> format()
      |> Enum.map(fn {fmt1, fmt2} ->
        fill(fmt1, "")
          |> List.flatten()
          |> Enum.filter(& valid?(&1, ".", fmt2))
          |> Enum.count()
      end)
      |> Enum.sum()
  end

end
