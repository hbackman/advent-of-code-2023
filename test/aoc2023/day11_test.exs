defmodule Aoc2023.Day11Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day11

  @input [:code.priv_dir(:aoc2023), "day11.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day11.part_one(@input) == 9536038
  end

  describe "part two" do
    assert Day11.part_two(@input) == 447744640566
  end

end
