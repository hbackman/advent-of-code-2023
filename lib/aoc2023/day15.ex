defmodule Aoc2023.Day15 do

  defp hash(string, hash \\ 0)
  defp hash(<<char::binary-size(1), string::binary>>, hash) do
    hash = hash
      |> Kernel.+(:binary.first(char))
      |> Kernel.*(17)
      |> rem(256)

    hash(string, hash)
  end

  defp hash(<<>>, hash), do: hash

  def part_one(input) do
    input
      |> String.split(",")
      |> Enum.map(&hash/1)
      |> Enum.sum()
  end

end
