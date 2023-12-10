defmodule Aoc2023.Day07Test do
  use ExUnit.Case, async: true

  alias Aoc2023.Day07

  @input [:code.priv_dir(:aoc2023), "day07.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    #assert Day07.part_one(@input) == 246912307
    #IO.inspect Day07.part_one(@input)
  end

  describe "part two" do
    IO.inspect Day07.part_two(@input)
  end

end
