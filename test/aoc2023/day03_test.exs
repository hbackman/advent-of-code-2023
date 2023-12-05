defmodule Aoc2023.Day03Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day03

  @input [:code.priv_dir(:aoc2023), "day03.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    #assert Day03.part_one(@input) == 557705
  end

  describe "part two" do
    IO.inspect Day03.part_two(@input)
  end

end
