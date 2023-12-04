defmodule Aoc2023.Day04Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day04

  @input [:code.priv_dir(:aoc2023), "day04.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    IO.inspect Day04.part_one(@input)
  end

  describe "part two" do
    #
  end

end
