defmodule Aoc2023.Day13 do

  defp format(input) do
    input
      |> String.split(~r/\R\R/)
      |> Enum.map(&Matrix.from/1)
  end

  defp solve(map = %Matrix{}) do
    x_range = 0..map.w
    y_range = 0..map.h

    x = Enum.find(x_range, fn x ->
      Enum.all?(y_range, fn y ->
        l = get_range(map, :y, y, 0..x)
        r = get_range(map, :y, y, (x+1)..(map.w-1))

        mirrored?(Enum.reverse(l), r)
      end)
    end)

    y = Enum.find(y_range, fn y ->
      Enum.all?(x_range, fn x ->
        l = get_range(map, :x, x, 0..y)
        r = get_range(map, :x, x, (y+1)..(map.h-1))

        mirrored?(Enum.reverse(l), r)
      end)
    end)

    cond do
      x    -> {:x, x + 1}
      y    -> {:y, y + 1}
      true -> nil
    end
  end

  defp get_range(map, :x, x, range),
    do: Enum.map(range, &Matrix.get(map, {x, &1}))

  defp get_range(map, :y, y, range),
    do: Enum.map(range, &Matrix.get(map, {&1, y}))

  defp mirrored?([l | ll], [r | rr]) do
    if l != r,
      do: false,
    else: mirrored?(ll, rr)
  end

  defp mirrored?([], _), do: true
  defp mirrored?(_, []), do: true

  def part_one(input) do
    input
      |> format()
      |> Enum.map(&solve/1)
      |> Enum.map(fn
        {:x, x} -> x
        {:y, y} -> y * 100
      end)
      |> Enum.sum()
  end

end
