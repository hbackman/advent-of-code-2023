defmodule Aoc2023.Day14Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day14

  @input [:code.priv_dir(:aoc2023), "day14.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    IO.inspect Day14.part_one(@input)
  end

  describe "part two" do
    #
  end

end