defmodule Aoc2023.Day14 do

  defp format(input) do
    Matrix.from(input)
  end

  defp find_rocks(matrix = %Matrix{}) do
    positions =
      for y <- Matrix.y_range(matrix),
          x <- Matrix.x_range(matrix),
      do: {x, y}

    Enum.filter(positions, fn {x, y} ->
      Matrix.get(matrix, {x, y}) == "O"
    end)
  end

  defp tilt(matrix = %Matrix{}, direction) do
    rocks = find_rocks(matrix)

    Enum.reduce(rocks, matrix, fn {x, y}, mat ->
      fall(mat, {x, y}, direction)
    end)
  end

  defp fall(matrix = %Matrix{}, {x, y}, :north) do
    case Matrix.get(matrix, {x, y - 1}) do
      nil -> matrix
      "O" -> matrix
      "#" -> matrix
      "." -> matrix
        |> Matrix.put({x, y-0}, ".")
        |> Matrix.put({x, y-1}, "O")
        |> fall({x, y-1}, :north)
    end
  end

  defp calc_load(matrix = %Matrix{}) do
    rocks = find_rocks(matrix)

    Enum.reduce(rocks, 0, fn {x, y}, acc ->
      acc + (matrix.h - y) - y + 1
    end)
  end

  defp print(matrix = %Matrix{}) do
    IO.puts matrix.data
      |> Enum.map(fn {_, row} ->
        row
          |> Map.to_list()
          |> Enum.map(&elem(&1, 1))
          |> Enum.join()
      end)
      |> Enum.join("\n")
    matrix
  end

  def part_one(input) do
    input
      |> format()
      |> tilt(:north)
      |> print()
      |> calc_load()
  end

end
