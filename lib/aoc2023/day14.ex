defmodule Aoc2023.Day14 do

  defp format(input) do
    Matrix.from(input)
  end

  defp find_rocks(matrix = %Matrix{}) do
    positions =
      for y <- Matrix.y_range(matrix),
          x <- Matrix.x_range(matrix),
      do: {x, y}

    Enum.filter(positions, & Matrix.get(matrix, &1) == "O")
  end

  defp tilt(matrix = %Matrix{}, direction) do
    find_rocks(matrix)
      |> Enum.sort(fn {x1, y1}, {x2, y2} ->
        case direction do
          :north -> y2 > y1
          :south -> y2 < y2
          :east  -> x2 < x1
          :west  -> x2 > x1
        end
      end)
      |> Enum.reduce(matrix, fn {x, y}, mat ->
        fall(mat, {x, y}, direction)
      end)
  end

  defp fall(matrix = %Matrix{}, curr = {x, y}, direction) do
    next = case direction do
      :north -> {x, y-1}
      :south -> {x, y+1}
      :east  -> {x+1, y}
      :west  -> {x-1, y}
    end

    case Matrix.get(matrix, next) do
      nil -> matrix
      "O" -> matrix
      "#" -> matrix
      "." -> matrix
        |> Matrix.put(curr, ".")
        |> Matrix.put(next, "O")
        |> fall(next, direction)
    end
  end

  defp calc_load(matrix = %Matrix{}) do
    rocks = find_rocks(matrix)

    Enum.reduce(rocks, 0, fn {_, y}, acc ->
      acc + (matrix.h - y)
    end)
  end

  def part_one(input) do
    input
      |> format()
      |> tilt(:north)
      |> calc_load()
  end

  defp spin(mat = %Matrix{}, n),
    do: spin(mat, n, %{})

  defp spin(mat = %Matrix{}, 0, _seen),
    do: mat

  defp spin(mat = %Matrix{}, n, seen) do
    mat = mat
      |> tilt(:north)
      |> tilt(:west)
      |> tilt(:south)
      |> tilt(:east)

    key = :erlang.term_to_binary(mat.data)

    if Map.has_key?(seen, key) do
      n2 = Map.get(seen, key)
      nd = n2 - n

      r = rem(n, nd)

      spin(mat, r - 1, %{})
    else
      spin(mat, n - 1, Map.put(seen, key, n))
    end
  end

  def part_two(input) do
    input
      |> format()
      |> spin(1_000_000_000)
      |> calc_load()
  end

end
