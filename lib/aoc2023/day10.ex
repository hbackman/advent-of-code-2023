defmodule Aoc2023.Day10 do

  defp get_edges(%Matrix{} = map) do
    positions =
      for y <- Matrix.y_range(map),
          x <- Matrix.x_range(map),
          do: {x, y}

    positions |> Enum.map(fn {x, y} ->
      case Matrix.get(map, {x, y}) do
        "|" -> {{x, y-1}, {x, y+1}} # north & south
        "-" -> {{x-1, y}, {x+1, y}} # west & east
        "L" -> {{x, y-1}, {x+1, y}} # north & east
        "J" -> {{x, y-1}, {x-1, y}} # north & west
        "7" -> {{x, y+1}, {x-1, y}} # south & west
        "F" -> {{x, y+1}, {x+1, y}} # south & east

        "S" -> nil
        "." -> nil
      end
    end)
  end

  def part_one(input) do
    edges = input
      |> Matrix.from()
      |> get_edges()
  end

end
