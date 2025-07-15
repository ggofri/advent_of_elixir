defmodule Year2015.Day02Test do
  use ExUnit.Case
  doctest Year2015.Day02

  test "(Day 02 - Challenge 1) works with sample input" do
    assert Year2015.Day02.solve_01("2x3x4") == 58
  end

  test "(Day 02 - Challenge 1) works with final input" do
    {:ok, input} = File.read("assets/year_2015/day_02/final_input_1.txt")
    assert Year2015.Day02.solve_01(input) == 1_606_483
  end

  test "(Day 02 - Challenge 2) works with sample input" do
    assert Year2015.Day02.solve_02("2x3x4\n1x1x10") == 48
  end

  test "(Day 02 - Challenge 2) works with final input" do
    {:ok, input} = File.read("assets/year_2015/day_02/final_input_2.txt")
    assert Year2015.Day02.solve_02(input) == 3842356
  end
end
