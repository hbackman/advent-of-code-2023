defmodule Aoc2023.Day08Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day08

  @input [:code.priv_dir(:aoc2023), "day08.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day08.part_one(@input) == 13301
  end

  describe "part two" do
    assert Day08.part_two(@input) == 7309459565207
  end

end
