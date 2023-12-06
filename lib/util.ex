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
end
