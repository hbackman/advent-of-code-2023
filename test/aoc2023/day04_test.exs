defmodule Aoc2023.Day04Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day04

  @input [:code.priv_dir(:aoc2023), "day04.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day04.part_one(@input) == 25651
  end

  describe "part two" do
    assert Day04.part_two(@input) == 19499881
  end

end
