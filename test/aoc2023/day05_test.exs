defmodule Aoc2023.Day05Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day05

  @input [:code.priv_dir(:aoc2023), "day05.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day05.part_one(@input) == 403695602
  end

  describe "part two" do
    #
  end

end
