defmodule Aoc2023.Day05 do

  defp parse(input) do
    [seeds | maps] = String.split(input, ~r/\R\R/, trim: true)

    seeds = seeds
      |> String.split(":", trim: true)
      |> List.last()
      |> Util.string_to_int_list()

    maps = Enum.map(maps, fn str ->
      [from, _, to, maps] = String.split(str, ["-", " map:"], trim: true)

      maps = maps
        |> String.split(~r/\R/, trim: true)
        |> Enum.map(&Util.string_to_int_list/1)
        |> Enum.map(fn [dst, src, len] ->
          {dst..(dst+len-1), src..(src+len-1)}
        end)

      {
        from,
        to,
        maps,
      }
    end)

    {seeds, maps}
  end

  defp solve({seeds, maps}) do
    Enum.map(seeds, & search(maps, &1, "seed"))
  end

  defp search(_maps, value, "location"),
    do: value

  defp search(maps, value, from) do
    {_, next, ranges} = Enum.find(maps, & elem(&1, 0) == from)

    value = case Enum.find(ranges, fn {_, src} -> value in src end) do
      {l1.._, l2.._} -> value - l2 + l1
      nil            -> value
    end

    search(maps, value, next)
  end

  def part_one(input) do
    input
      |> parse()
      |> solve()
      |> Enum.min()
  end

end
