defmodule Aoc2023.Day02Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day02

  @input [:code.priv_dir(:aoc2023), "2023", "day02.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day02.part_one(@input) == 2085
  end

  describe "part two" do
    assert Day02.part_two(@input) == 79315
  end

end
