defmodule Aoc2023.Day07Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day07

  @input [:code.priv_dir(:aoc2023), "day07.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day07.part_one(@input) == 246912307
  end

  describe "part two" do
    assert Day07.part_two(@input) == 246894760
  end

end
