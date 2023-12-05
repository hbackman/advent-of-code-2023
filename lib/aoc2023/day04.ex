defmodule Aoc2023.Day04 do

  defp parse(card) do
    [_, wins, play] = String.split(card, [":", "|"])
    {
      fmt_numbers(wins),
      fmt_numbers(play),
    }
  end

  defp fmt_numbers(numbers) do
    numbers
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  defp winners({wins, play}) do
    play
      |> Enum.filter(&Enum.member?(wins, &1))
      |> Enum.count()
  end

  defp score({wins, play}) do
    case winners({wins, play}) do
      0 -> 0
      n -> 2**(n-1)
    end
  end

  def part_one(input) do
    input
      |> String.split(~r/\R/)
      |> Enum.map(&parse/1)
      |> Enum.map(&score/1)
      |> Enum.sum()
  end

  defp play(cards, index \\ 0) do
    case winners(Enum.at(cards, index)) do
      0 -> 1
      n -> index+1..index+n
        |> Enum.to_list()
        |> Enum.reduce(1, fn i, total ->
          total + play(cards, i)
        end)
    end
  end

  def part_two(input) do
    cards = input
      |> String.split(~r/\R/)
      |> Enum.map(&parse/1)
    cards
      |> Enum.with_index()
      |> Enum.map(fn {_, index} -> play(cards, index) end)
      |> Enum.sum()
  end

end
