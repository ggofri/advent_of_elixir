defmodule Year2015.Day03Test do
  use ExUnit.Case
  doctest Year2015.Day03

  test "(Day 03 - Challenge 1) works with sample input" do
    assert Year2015.Day03.solve_01("^>v<^v^v^v^v^v") == 4
  end

  test "(Day 03 - Challenge 1) works with final input" do
    {:ok, input} = File.read("assets/year_2015/day_03/final_input_1.txt")
    assert Year2015.Day03.solve_01(input) == 2572
  end

  test "(Day 03 - Challenge 2) works with sample input" do
    assert Year2015.Day03.solve_02("^v^v^v^v^v") == 11
  end

  test "(Day 03 - Challenge 2) works with final input" do
    {:ok, input} = File.read("assets/year_2015/day_03/final_input_2.txt")
    assert Year2015.Day03.solve_02(input) == 2631
  end
end
