defmodule Aoc2023.Day08 do

  defp parse(input) do
    [path | rest] = String.split(input, ~r/\R/, trim: true)

    map = rest
      |> Enum.map(&parse_nodes/1)
      |> Map.new()

    {path, map}
  end

  defp parse_nodes(string) do
    <<
      f::binary-size(3), " = (",
      l::binary-size(3), ", ",
      r::binary-size(3), ")"
    >> = string

    {f, {l, r}}
  end

  defp next(inst, step) do
    String.at(inst, rem(step, String.length(inst)))
  end

  defp traverse({inst, map}, pos, n, ends_with) do
    next = case next(inst, n) do
      "L" -> elem(map[pos], 0)
      "R" -> elem(map[pos], 1)
    end

    if ! String.ends_with?(next, ends_with) do
      traverse({inst, map}, next, n + 1, ends_with)
    else
      n + 1
    end
  end

  def part_one(input) do
    input
      |> parse()
      |> traverse("AAA", 0, "ZZZ")
  end

  def part_two(input) do
    {inst, map} = input
      |> parse()

    map
      |> Map.keys()
      |> Enum.filter(&String.ends_with?(&1, "A"))
      |> Enum.map(&traverse({inst, map}, &1, 0, "Z"))
      |> Enum.reduce(1, fn e, c ->
        trunc(Util.lcm(e, c))
      end)
  end

end
