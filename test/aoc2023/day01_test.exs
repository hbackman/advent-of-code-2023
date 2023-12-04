defmodule Aoc2023.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day01

  @input [:code.priv_dir(:aoc2023), "day01.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day01.part_one(@input) == 56397
  end

  describe "part two" do
    assert Day01.part_two(@input) == 55701
  end

end
