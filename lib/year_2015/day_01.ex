defmodule Year2015.Day01 do
  @moduledoc """
  Year 2015, Day 01, Challenge 1
  """

  def solve_01 input do
    input
    |> String.graphemes
    |> Enum.reduce(0, fn char, acc -> char == "(" && acc + 1 || acc - 1 end)
  end

  defp find_basement(_input, level, iterations) when level == -1 do
    iterations
  end
  defp find_basement(input, _level, _iterations) when length(input) == 0 do
    0
  end
  defp find_basement(input, level, iterations) do
    [first | rest] = input
    new_iterations = iterations + 1
    case first do
      "(" -> find_basement(rest, level + 1, new_iterations)
      _ -> find_basement(rest, level - 1, new_iterations)
    end
  end

  def solve_02(input) do
    input_to_list = String.graphemes(input)
    find_basement(input_to_list, 0, 0)
  end
end
