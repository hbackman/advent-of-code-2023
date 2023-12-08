defmodule Util do

  @doc """
  Formats a string as a list of integers.

  ## Examples

    iex> Util.string_to_int_list("13 18 15")
    [13, 18, 15]

    iex> Util.string_to_int_list("12,19,14", ",")
    [12, 19, 14]

  """
  def string_to_int_list(string, separator \\ " ") do
    string
      |> String.split(separator, trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Returns a list of results invoking `fun` on every odd element of `enum`.

  ## Examples

    iex> Util.map_every_2([1, 2, 3, 4], & &1*2)
    [2, 2, 6, 4]

    iex> Util.map_every_2([1, 2, 3, 4], & &1*2, true)
    [1, 4, 3, 8]
  """
  def map_every_2(enum, fun, true) when is_list(enum) do
    [head | tail] = enum
    [head | Enum.map_every(tail, 2, fun)]
  end

  def map_every_2(enum, fun, false) when is_list(enum),
    do: Enum.map_every(enum, 2, fun)

  def map_every_2([], _, _), do: []

  def map_every_2(enum, fun),
    do: map_every_2(enum, fun, false)

end
