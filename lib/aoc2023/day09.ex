defmodule Aoc2023.Day09 do

  defp format(input) do
    input
      |> Util.string_split_lines()
      |> Enum.map(&Util.string_to_int_list/1)
  end

  defp deltas(sequence),
    do: deltas(sequence, [sequence])

  defp deltas(sequence, acc) do
    if Enum.uniq(sequence) === [0] do
      acc
    else
      sequence = sequence
        |> Enum.map_reduce(0, &{&1 - &2, &1})
        |> elem(0)
        |> Enum.drop(1)

      deltas(sequence, [sequence | acc])
    end
  end

  def part_one(input) do
    input
      |> format()
      |> Enum.map(fn seq ->
        seq
          |> deltas()
          |> Enum.map(&List.last/1)
          |> Enum.sum()
      end)
      |> Enum.sum()
  end

  defp extrapolate_left(sequence) do
    sequence
      |> deltas()
      |> Enum.map(&List.first/1)
      |> List.foldl({0, []}, fn a, {b, acc} ->
        {a-b, [a-b | acc]}
      end)
      |> elem(1)
      |> List.first()
  end

  def part_two(input) do
    input
      |> format()
      |> Enum.map(&extrapolate_left/1)
      |> Enum.sum()
  end

end
