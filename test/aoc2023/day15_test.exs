defmodule Aoc2023.Day15Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day15

  @input [:code.priv_dir(:aoc2023), "day15.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day15.part_one(@input) == 516804
  end

  describe "part two" do
    # IO.inspect Day15.part_two(@input)
  end

end
