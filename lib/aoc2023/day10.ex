defmodule Aoc2023.Day10 do

  defp get_start(%Matrix{data: data}) do
    Enum.find_value(data, fn {y, row} ->
      Enum.find_value(row, fn {x, val} ->
        if val == "S",
          do: {x, y},
        else: nil
      end)
    end)
  end

  defp get_edges(%Matrix{} = map) do
    positions =
      for y <- Matrix.y_range(map),
          x <- Matrix.x_range(map),
          do: {x, y}

    positions
      |> Enum.map(fn {x, y} ->
        connections(map, {x, y})
          |> Enum.filter(fn p -> connection?(map, {x, y}, p) end)
          |> Enum.map(fn p -> {{x, y}, p} end)
      end)
        |> List.flatten()
  end

  defp connections(map, {x, y}) do
    case Matrix.get(map, {x, y}) do
      "|" -> [{x, y-1}, {x, y+1}] # north & south
      "-" -> [{x-1, y}, {x+1, y}] # west & east
      "L" -> [{x, y-1}, {x+1, y}] # north & east
      "J" -> [{x, y-1}, {x-1, y}] # north & west
      "7" -> [{x, y+1}, {x-1, y}] # south & west
      "F" -> [{x, y+1}, {x+1, y}] # south & east
      "." -> []
      "S" -> [
        {x-1, y}, {x+1, y},
        {x, y-1}, {x, y+1},
      ]
      nil -> []
    end
  end

  defp connection?(map, {x, y}, other) do
    Enum.member?(connections(map, other), {x, y})
  end

  def part_one(input) do
    g = :digraph.new()

    m = Matrix.from(input)
    m |> get_edges() |> Enum.each(fn {p1, p2} ->
      :digraph.add_vertex(g, p1)
      :digraph.add_vertex(g, p2)
      :digraph.add_edge(g, p1, p2)
    end)

    cycle = :digraph.get_cycle(g, get_start(m))

    floor(Enum.count(cycle) / 2)
  end

end
