defmodule Aoc2023.Day13 do

  defp format(input) do
    input
      |> String.split(~r/\R\R/)
      |> Enum.map(&Matrix.from/1)
  end

  defp find_reflections(map = %Matrix{}, smudges \\ 0) do
    num_x = find_reflected_rows(map, smudges)
    num_y = find_reflected_rows(map |> Matrix.transpose(), smudges)

    [{:x, num_x}, {:y, num_y}]
  end

  defp find_reflected_rows(map = %Matrix{}, smudges) do
    Enum.find(0..map.w, fn x ->
      diffs = Enum.map(0..map.h, fn y ->
        l = get_range(map, y, 0..x)
        r = get_range(map, y, (x+1)..(map.w-1))

        diff(Enum.reverse(l), r)
      end)

      Enum.sum(diffs) == smudges
    end)
  end

  defp calc_scores(reflections) do
    reflections
      |> Enum.map(fn
        {_, nil} -> 0
        {:x,  x} -> (x + 1)
        {:y,  y} -> (y + 1) * 100
      end)
      |> Enum.sum()
  end

  defp diff(left, right, diff \\ 0)

  defp diff([l | ll], [r | rr], diff) do
    if l != r,
      do: diff(ll, rr, diff + 1),
    else: diff(ll, rr, diff)
  end

  defp diff([], _, diff), do: diff
  defp diff(_, [], diff), do: diff

  defp get_range(map, y, range),
    do: Enum.map(range, &Matrix.get(map, {&1, y}))

  def part_one(input) do
    input
      |> format()
      |> Enum.map(&find_reflections/1)
      |> Enum.map(&calc_scores/1)
      |> Enum.sum()
  end

  def part_two(input) do
    input
      |> format()
      |> Enum.map(&find_reflections(&1, 1))
      |> Enum.map(&calc_scores/1)
      |> Enum.sum()
  end
end
