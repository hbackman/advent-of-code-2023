defmodule Aoc2023.Day12Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day12

  @input [:code.priv_dir(:aoc2023), "day12.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day12.part_one(@input) == 7460
  end

  describe "part two" do
    assert Day12.part_two(@input) == 6720660274964
  end

end
