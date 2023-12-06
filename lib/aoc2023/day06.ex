defmodule Aoc2023.Day06 do

  defp parse(input) do
    [
      "Time:"     <> races_t,
      "Distance:" <> races_d,
    ] = String.split(input, ~r/\R/)

    Enum.zip([
      Util.string_to_int_list(races_t),
      Util.string_to_int_list(races_d),
    ])
  end

  defp parse(input, true) do
    parse(String.replace(input, " ", ""))
  end

  defp solve(races) do
    Enum.map(races, fn {time, dist} ->
      # f(x) = (T-x)x
      #  => x^2 - Tx > D
      #  => x^2 - Tx + D = 0

      x0 = (time - :math.sqrt(time**2 - 4*dist)) / 2
      x1 = (time + :math.sqrt(time**2 - 4*dist)) / 2

      ceil(x1) - floor(x0) - 1
    end)
  end

  def part_one(input) do
    input
      |> parse()
      |> solve()
      |> Enum.product()
  end

  def part_two(input) do
    input
      |> parse(true)
      |> solve()
      |> Enum.product()
  end

end
