defmodule Aoc2023.Day11 do

  defp format(input),
    do: Matrix.from(input)

  defp search_galaxies(matrix = %Matrix{}) do
    positions =
      for y <- Matrix.y_range(matrix),
          x <- Matrix.x_range(matrix),
          do: {x, y}

    Enum.filter(positions, fn pos ->
      case Matrix.get(matrix, pos) do
        "#" -> true
        "." -> false
      end
    end)
  end

  defp expand_galaxies(galaxies, rate \\ 1) do
    galaxies = for {x, y} <- galaxies do
      gx = Enum.map(galaxies, &elem(&1, 0)) |> Enum.uniq() |> Enum.count(& &1 < x)
      gy = Enum.map(galaxies, &elem(&1, 1)) |> Enum.uniq() |> Enum.count(& &1 < y)

      {x + (x - gx) * rate, y + (y - gy) * rate}
    end

    Util.comb(galaxies, 2)
  end

  defp manhattan([point_a, point_b]) do
    {ax, ay} = point_a
    {bx, by} = point_b
    abs(ax - bx) + abs(ay - by)
  end

  def part_one(input) do
    input
      |> format()
      |> search_galaxies()
      |> expand_galaxies()
      |> Enum.map(&manhattan/1)
      |> Enum.sum()
  end

  def part_two(input) do
    input
      |> format()
      |> search_galaxies()
      |> expand_galaxies(999_999)
      |> Enum.map(&manhattan/1)
      |> Enum.sum()
  end

end
