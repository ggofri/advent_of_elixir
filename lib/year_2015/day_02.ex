defmodule Year2015.Day02 do
  @moduledoc """
  Year 2015, Day 02
  """

  @spec parse_input_to_list(String.t()) :: list(String.t())
  def parse_input_to_list(input) do
    input
    |> String.split("\n", trim: true)
  end

  @spec get_box_dimensions(String.t()) :: list(number())
  def get_box_dimensions(box_string) do
    box_string
    |> String.split("x", trim: true)
    |> Enum.map(fn n -> String.to_integer(n) end)
  end

  @spec calculate_box_area(String.t()) :: number()
  def calculate_box_area(box_string) do
    areas_list =
      box_string
      |> get_box_dimensions
      |> then(fn [l, w, h] -> [l * w, w * h, h * l] end)

    min_area = Enum.min(areas_list)

    Enum.reduce(areas_list, min_area, fn area, acc -> acc + 2 * area end)
  end

  @spec solve_01(String.t()) :: number()
  def solve_01(input) do
    input
    |> parse_input_to_list
    |> Enum.map(fn box_string -> calculate_box_area(box_string) end)
    |> Enum.reduce(0, fn box_area, acc -> acc + box_area end)
  end

  @spec calculate_ribbon_for_box(String.t()) :: number()
  def calculate_ribbon_for_box(box_string) do
    [min, mid, max] =
      get_box_dimensions(box_string)
      |> Enum.sort()

    wrap = min * 2 + mid * 2
    bow = min * mid * max

    wrap + bow
  end

  @spec solve_02(String.t()) :: number()
  def solve_02(input) do
    input
    |> parse_input_to_list
    |> Enum.map(fn box_string -> calculate_ribbon_for_box(box_string) end)
    |> Enum.sum()
  end
end
