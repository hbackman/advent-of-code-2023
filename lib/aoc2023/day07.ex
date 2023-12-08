defmodule Aoc2023.Day07 do

  @cards ~w(1 2 3 4 5 6 7 8 9 T J Q K A)

  defp format(input) do
    input
      |> String.split(~r/(\R|\ )/)
      |> Util.map_every_2(&String.split(&1, "", trim: true))
      |> Util.map_every_2(&String.to_integer/1, true)
      |> Enum.chunk_every(2)
      |> Enum.map(&List.to_tuple/1)
  end

  defp parse_types(hands) do
    Enum.map(hands, fn {hand, bid} ->
      uniq = unique_cards(hand)

      type_score = cond do
        at(uniq, 0) == 5 ->
          7 # :five_of_a_kind

        at(uniq, 0) == 4 ->
          6 # :four_of_a_kind

        at(uniq, 0) == 3 and at(uniq, 1) == 2 ->
          5 # :full_house

        at(uniq, 0) == 3 and length(uniq) > 2 ->
          4 # :three_of_a_kind

        at(uniq, 0) == 2 and at(uniq, 1) == 2 ->
          3 # :two_pair

        at(uniq, 0) == 2 and length(uniq) == 4 ->
          2 # :one_pair

        length(uniq) == 5 ->
          1 # :high_card

        true -> 0
      end

      hand_score = hand
        |> Enum.map(&card_to_sort/1)
        |> Enum.join()

      {hand, bid, type_score, hand_score}
    end)
  end

  defp card_to_sort(card),
    do: List.to_string([?a + Enum.find_index(@cards, & &1 == card)])

  defp at(enum, index),
    do: Enum.at(enum, index)

  defp unique_cards(hand) do
    hand
      |> Enum.group_by(& &1)
      |> Map.values()
      |> Enum.map(& length(&1))
      |> Enum.sort()
      |> Enum.reverse()
  end

  def part_one(input) do
    input
      |> format()
      |> parse_types()
      |> Enum.sort_by(& {elem(&1, 2), elem(&1, 3)})
      |> Enum.with_index()
      |> Enum.map(fn {{_, bid, _, _}, index} -> bid * (index + 1) end)
      |> Enum.sum()
  end

end
