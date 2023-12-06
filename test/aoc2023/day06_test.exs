defmodule Aoc2023.Day06Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day06

  @input [:code.priv_dir(:aoc2023), "day06.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    # IO.inspect Day06.part_one(@input)
  end

  describe "part two" do
    IO.inspect Day06.part_two(@input)
  end

end
