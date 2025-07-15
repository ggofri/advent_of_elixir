defmodule Year2015.Day03 do
  @moduledoc """
  Year 2015, Day 03
  """
  @spec find_or_create(list({number(), number()}), {number(), number()}) ::
          list({number(), number()})
  defp find_or_create(list, expected_value) do
    found = Enum.find_index(list, fn value -> value == expected_value end)

    case found do
      nil -> [expected_value | list]
      _ -> list
    end
  end

  @spec move_to_adjacent_house(list(String.t()), list({number(), number()})) :: number()
  defp move_to_adjacent_house(list, visited_houses \\ [{0, 0}], current_position \\ {0, 0})

  defp move_to_adjacent_house(list, visited_houses, _current_position) when length(list) == 0 do
    length(visited_houses)
  end

  defp move_to_adjacent_house(list, visited_houses, {current_x, current_y}) do
    [current_step | remaining_steps] = list

    new_position =
      case current_step do
        "^" -> {current_x, current_y + 1}
        ">" -> {current_x + 1, current_y}
        "v" -> {current_x, current_y - 1}
        "<" -> {current_x - 1, current_y}
      end

    new_visited_houses = find_or_create(visited_houses, new_position)
    move_to_adjacent_house(remaining_steps, new_visited_houses, new_position)
  end

  @spec solve_01(String.t()) :: number()
  def solve_01(input) do
    String.graphemes(input)
    |> move_to_adjacent_house
  end

  @spec move(String.t(), {number(), number()}) :: {number(), number()}
  defp move(step, {current_x, current_y}) do
    case step do
        "^" -> {current_x, current_y + 1}
        ">" -> {current_x + 1, current_y}
        "v" -> {current_x, current_y - 1}
        "<" -> {current_x - 1, current_y}
      end
  end

  @spec travel_houses(list(String.t()), list({number(), number()}), {{number(), number()}, {number(), number()}}) :: number()
  defp travel_houses(steps, visited_houses\\[{0, 0}], tuple_positions\\{{0, 0}, {0, 0}})
  defp travel_houses(steps, visited_houses, _tuple_positions) when length(steps) == 0 do
    length(visited_houses)
  end
  defp travel_houses(steps, visited_houses, {current_santa_position, current_robot_position}) do
    [current_santa_step, current_robot_step | rest_steps] = steps

    new_santa_position = move(current_santa_step, current_santa_position)
    new_robot_position = move(current_robot_step, current_robot_position)

    new_visited_houses = find_or_create(visited_houses, new_santa_position)
    |> find_or_create(new_robot_position)

    travel_houses(rest_steps, new_visited_houses, {new_santa_position, new_robot_position})
  end

  def solve_02(input) do
      input
      |> String.graphemes()
      |> travel_houses()
  end
end
