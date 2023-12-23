defmodule Aoc2023.Day12 do

  defp format(input) do
    input
      |> Util.string_split_lines()
      |> Enum.map(fn line ->
        [fmt1, fmt2] = String.split(line, " ")
        {fmt1, fmt2 |> Util.string_to_int_list(",")}
      end)
  end

  defp aux("", _, _, [], memo),
    do: {1, memo}

  defp aux("", _, _, [0], memo),
    do: {1, memo}

  defp aux("", _, _, _, memo),
    do: {0, memo}

  defp aux("#" <> _, _, _, [], memo),
    do: {0, memo}

  defp aux("#" <> _, _, _, [0 | _], memo),
    do: {0, memo}

  defp aux("#" <> rest, i, _, [h | t], memo),
    do: aux(rest, i + 1, "#", [h-1 | t], memo)

  defp aux("." <> rest, i, _, [], memo),
    do: aux(rest, i + 1, ".", [], memo)

  defp aux("." <> rest, i, "#", [0 | t], memo),
    do: aux(rest, i + 1, ".", t, memo)

  defp aux("." <> _, _, "#", [_ | _], memo),
    do: {0, memo}

  defp aux("." <> rest, i, ".", counters, memo),
    do: aux(rest, i + 1, ".", counters, memo)

  defp aux("?" <> rest, i, "#", [], memo),
    do: aux(rest, i + 1, ".", [], memo)

  defp aux("?" <> rest, i, "#", [0 | t], memo),
    do: aux(rest, i + 1, ".", t, memo)

  defp aux("?" <> rest, i, "#", [h | t], memo),
    do: aux(rest, i + 1, "#", [h-1 | t], memo)

  defp aux("?" <> rest, i, ".", [], memo),
    do: aux(rest, i + 1, ".", [], memo)

  defp aux("?" <> rest, i, ".", [0 | t], memo),
    do: aux(rest, i + 1, ".", t, memo)

  defp aux("?" <> rest, i, ".", [h | t], memo) do
    memoized(memo, {i, [h | t]}, fn ->
      {a, memo} = aux(rest, i + 1, "#", [h-1 | t], memo)
      {b, memo} = aux(rest, i + 1, ".", [h   | t], memo)
      {a + b, memo}
    end)
  end

  defp memoized(memo, key, fun) do
    with nil <- Map.get(memo, key) do
      {result, memo} = fun.()
      memo = Map.put(memo, key, result)
      {result, memo}
    else
      result -> {result, memo}
    end
  end

  def part_one(input) do
    input
      |> format()
      |> Enum.map(fn {fmt1, fmt2} ->
        aux(fmt1, 0, ".", fmt2, %{})
      end)
      |> Enum.map(&elem(&1, 0))
      |> Enum.sum()
  end

  defp unfold({fmt1, fmt2}) do
    {
      fmt1 |> List.duplicate(5) |> Enum.join("?"),
      fmt2 |> List.duplicate(5) |> Enum.concat(),
    }
  end

  def part_two(input) do
    input
      |> format()
      |> Enum.map(&unfold/1)
      |> Enum.map(fn {fmt1, fmt2} ->
        aux(fmt1, 0, ".", fmt2, %{})
      end)
      |> Enum.map(&elem(&1, 0))
      |> Enum.sum()
  end

end
