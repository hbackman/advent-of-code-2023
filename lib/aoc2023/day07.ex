defmodule Aoc2023.Day07 do

  @cards_a ~w(1 2 3 4 5 6 7 8 9 T J Q K A)
  @cards_b ~w(J 1 2 3 4 5 6 7 8 9 T Q K A)

  defp format(input) do
    input
      |> String.split(~r/(\R|\ )/)
      |> Util.map_every_2(&String.split(&1, "", trim: true))
      |> Util.map_every_2(&String.to_integer/1, true)
      |> Enum.chunk_every(2)
      |> Enum.map(&List.to_tuple/1)
  end

  defp parse_types(hands, parsed \\ [])
  defp parse_types([{hand, bid} | hands], parsed) do
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

    parse_types(hands, [{hand, bid, type_score, hand_score} | parsed])
  end

  defp parse_types([], parsed),
    do: parsed

  defp card_to_sort(card),
    do: List.to_string([?a + Enum.find_index(@cards_a, & &1 == card)])

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

  defp unique_cards_2(hand) do
    hand
      |> Enum.group_by(& &1)
      |> Enum.map(& {elem(&1, 0), length(elem(&1, 1))})
      |> Enum.sort_by(& elem(&1, 1), :desc)
  end

  defp handle_joker(hand) do
    if Enum.member?(hand, "J") do
      {max, _} = unique_cards_2(hand)
        |> Enum.reject(& elem(&1, 0) == "J")
        |> List.first()
        || {"J", 5}

      Enum.map(hand, fn
        "J" -> max
        chr -> chr
      end)
    else
      hand
    end
  end

  defp parse_types_2(hands, parsed \\ [])
  defp parse_types_2([{hand, bid} | hands], parsed) do

    hand_sort = hand
      |> Enum.map(fn c ->
        List.to_string([?a + Enum.find_index(@cards_b, & &1 == c)])
      end)
      |> Enum.join()

    uniq = hand
      |> handle_joker()
      |> unique_cards_2()
      |> Enum.map(& elem(&1, 1))

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

    parse_types_2(hands, [{hand, bid, type_score, hand_sort} | parsed])
  end

  defp parse_types_2([], parsed),
    do: parsed

  def part_two(input) do
    input
      |> format()
      |> parse_types_2()
      |> Enum.sort_by(& {elem(&1, 2), elem(&1, 3)})
      |> Enum.with_index()
      |> Enum.map(fn {{_, bid, _, _}, index} -> bid * (index + 1) end)
      |> Enum.sum()
  end

end
