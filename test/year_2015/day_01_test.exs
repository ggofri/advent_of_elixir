defmodule Year2015.Day01Test do
  use ExUnit.Case
  doctest Year2015.Day01

  test "(Day 1 - Challenge 1) Sample input" do
    assert Year2015.Day01.solve_01(")())())(()(()(") == 0
  end

  test "(Day 1 - Challenge 1) Final input" do
    {:ok, input} = File.read("assets/year_2015/day_01/final_input_1.txt")
    assert Year2015.Day01.solve_01(input) == 280
  end

  test "(Day 1 - Challenge 2) Sample input" do
    assert Year2015.Day01.solve_02("()())") == 5
  end

  test "(Day 1 - Challenge 2) Final input" do
    {:ok, input} = File.read("assets/year_2015/day_01/final_input_2.txt")
    assert Year2015.Day01.solve_02(input) == 1797
  end
end
