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
      |> Enum.map(& elem(&1, 1))

    type_sort = calc_type_sort(uniq)
    hand_sort = calc_hand_sort(hand, @cards_a)

    parse_types(hands, [{hand, bid, type_sort, hand_sort} | parsed])
  end

  defp parse_types([], parsed),
    do: parsed

  # Caclulates a numeric sort value for the hand type.
  defp calc_type_sort(uniq) do
    cond do
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
  end

  # Calculates a numeric sort value for the hand score.
  defp calc_hand_sort(hand, dictionary) do
    hand
      |> Enum.map(fn c ->
        List.to_string([?a + Enum.find_index(dictionary, & &1 == c)])
      end)
      |> Enum.join()
  end

  defp at(enum, index),
    do: Enum.at(enum, index)

  defp unique_cards(hand) do
    hand
      |> Enum.group_by(& &1)
      |> Enum.map(& {elem(&1, 0), length(elem(&1, 1))})
      |> Enum.sort_by(& elem(&1, 1), :desc)
  end

  defp solve_winnings(hands) do
    hands
      |> Enum.sort_by(& {elem(&1, 2), elem(&1, 3)})
      |> Enum.with_index()
      |> Enum.map(fn {{_, bid, _, _}, index} -> bid * (index + 1) end)
      |> Enum.sum()
  end

  def part_one(input) do
    input
      |> format()
      |> parse_types()
      |> solve_winnings()
  end

  defp handle_joker(hand) do
    if Enum.member?(hand, "J") do
      {max, _} = unique_cards(hand)
        |> Enum.reject(& elem(&1, 0) == "J" and elem(&1, 1) < 5)
        |> List.first()

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
    uniq = hand
      |> handle_joker()
      |> unique_cards()
      |> Enum.map(& elem(&1, 1))

    type_sort = calc_type_sort(uniq)
    hand_sort = calc_hand_sort(hand, @cards_b)

    parse_types_2(hands, [{hand, bid, type_sort, hand_sort} | parsed])
  end

  defp parse_types_2([], parsed),
    do: parsed

  def part_two(input) do
    input
      |> format()
      |> parse_types_2()
      |> solve_winnings()
  end

end
