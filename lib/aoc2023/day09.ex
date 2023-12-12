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

  defp find_previous(sequences) do
    {res, _} = Enum.map_reduce(sequences, nil, fn
      a, nil -> {a ++ [0], a ++ [0]}
      a, acc ->
        seq_a = List.first(acc)
        seq_b = List.first(a)

        a = [seq_b - seq_a | a]

        {a, a}
    end)
    res
  end

  def part_two(input) do
    input
      |> format()
      |> Enum.map(fn sequence ->
        sequence
          |> deltas()
          |> find_previous()
          |> List.last()
          |> List.first()
      end)
      |> Enum.sum()
  end

end
