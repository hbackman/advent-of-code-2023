defmodule Aoc2023.Day13Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day13

  @input [:code.priv_dir(:aoc2023), "day13.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day13.part_one(@input) == 37025
  end

  describe "part two" do
    assert Day13.part_two(@input) == 32854
  end

end
