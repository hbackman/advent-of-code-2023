defmodule Aoc2023.Day08 do

  defp parse(input) do
    [path | rest] = String.split(input, ~r/\R/, trim: true)

    nodes = rest
      |> Enum.map(&parse_nodes/1)
      |> Map.new()

    {path, nodes}
  end

  defp parse_nodes(string) do
    [f, l, r] = Regex.run(~r/(\w+)\ =\ \((\w+),\ (\w+)\)/, string, capture: :all_but_first)
    {f, {l, r}}
  end

  defp next(inst, step) do
    String.at(inst, rem(step, String.length(inst)))
  end

  defp traverse(_, pos, step \\ 0)
  defp traverse(_, "ZZZ", step) do
    step
  end

  defp traverse({inst, maps}, pos, step) do
    next = case next(inst, step) do
      "L" -> elem(maps[pos], 0)
      "R" -> elem(maps[pos], 1)
    end

    traverse({inst, maps}, next, step + 1)
  end

  def part_one(input) do
    input
      |> parse
      |> traverse("AAA")
  end

end
