defmodule Aoc2023.Day06Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day06

  @input [:code.priv_dir(:aoc2023), "day06.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day06.part_one(@input) == 4568778
  end

  describe "part two" do
    assert Day06.part_two(@input) == 28973936
  end

end
