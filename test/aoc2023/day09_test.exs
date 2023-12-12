defmodule Aoc2023.Day09Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day09

  @input [:code.priv_dir(:aoc2023), "day09.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day09.part_one(@input) == 1877825184
  end

  describe "part two" do
    assert Day09.part_two(@input) == 1108
  end

end
