defmodule Aoc2023.Day10Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day10

  @input [:code.priv_dir(:aoc2023), "day10.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day10.part_one(@input) == 6927
  end

  describe "part two" do
    assert Day10.part_two(@input) == 467
  end

end
