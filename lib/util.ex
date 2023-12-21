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
  Formats a string as a list.

  ## Examples

    iex> Util.string_split_lines("hello\\nworld")
    ["hello", "world"]

    iex> Util.string_split_lines("hello\\nworld\\n")
    ["hello", "world"]

  """
  def string_split_lines(string) do
    String.split(string, ~r/\R/, trim: true)
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

  @doc """
  Calculate the greatest common divisor of two given number.
  """
  def gcd(a, 0), do: a
	def gcd(0, b), do: b
	def gcd(a, b), do: gcd(b, rem(a, b))

  @doc """
  Calculate the lowest common multiple of two given numbers.
  """
	def lcm(0, 0), do: 0
	def lcm(a, b), do: (a * b) / gcd(a, b)

  @doc """
  Generate combinations.
  """
  def comb(_, 0), do: [[]]
  def comb([], _), do: []

  def comb([h | t], m) do
    (for l <- comb(t, m-1), do: [h|l]) ++ comb(t, m)
  end

end
