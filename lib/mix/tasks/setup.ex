defmodule Mix.Tasks.Setup do
  use Mix.Task

  @shortdoc "Sets up the file structure for an Advent of Code day"
  @moduledoc """
  Sets up the file structure for an Advent of Code day.

  ## Usage

      mix setup -y YEAR -d DAY

  ## Examples

      mix setup -y 2015 -d 1

  This will create the following structure:

      lib/
        year_2015/
          day_01.ex
      test/
        year_2015/
          day_01_test.exs
      assets/
        year_2015/
          day_01/
            final_input_1.txt
            final_input_2.txt
  """

  @impl Mix.Task
  def run(args) do
    {options, _, _} = OptionParser.parse(args, strict: [year: :integer, day: :integer])

    year = options[:year] || raise "Year is required. Use -y or --year"
    day = options[:day] || raise "Day is required. Use -d or --day"

    create_directory_structure(year, day)
    create_template_files(year, day)
    create_asset_files(year, day)

    IO.puts("Setup completed for Year #{year}, Day #{day}")
  end

  defp create_directory_structure(year, day) do
    day_str = String.pad_leading("#{day}", 2, "0")

    dirs = [
      "lib/year_#{year}",
      "test/year_#{year}",
      "assets/year_#{year}/day_#{day_str}"
    ]

    Enum.each(dirs, &File.mkdir_p!/1)
  end

  defp create_template_files(year, day) do
    day_str = String.pad_leading("#{day}", 2, "0")

    create_challenge_files(year, day_str)
    create_test_files(year, day_str)
  end

  defp create_challenge_files(year, day_str) do
    Enum.each([1, 2], fn _ ->
      challenge_content = """
      defmodule Year#{year}.Day#{day_str} do
        @moduledoc \"\"\"
        Year #{year}, Day #{day_str}
        \"\"\"

        def solve_01(input) do
          # Implement your solution here
          input
        end

        def solve_02(input) do
          # Implement your solution here
          input
        end
      end
      """

      File.write!("lib/year_#{year}/day_#{day_str}.ex", challenge_content)
    end)
  end

  defp create_test_files(year, day_str) do
    Enum.each([1, 2], fn challenge ->
      test_content = """
      defmodule Year#{year}.Day#{day_str}Test do
        use ExUnit.Case
        doctest Year#{year}.Day#{day_str}

        test "(Day #{day_str} - Challenge 1) works with sample input" do
          assert Year#{year}.Day#{day_str}.solve_01('') == :none
        end

        test "(Day #{day_str} - Challenge 1) works with final input" do
          {:ok, input} = File.read("assets/year_#{year}/day_#{day_str}/final_input_#{challenge}.txt")
          assert Year#{year}.Day#{day_str}.solve_01(input) == :none
        end

        test "(Day #{day_str} - Challenge 2) works with sample input" do
          assert Year#{year}.Day#{day_str}.solve_02("") == :none
        end

        test "(Day #{day_str} - Challenge 2) works with final input" do
          {:ok, input} = File.read("assets/year_#{year}/day_#{day_str}/final_input_#{challenge}.txt")
          assert Year#{year}.Day#{day_str}.solve_02(input) == :none
        end
      end
      """

      File.write!("test/year_#{year}/day_#{day_str}_test.exs", test_content)
    end)
  end

  defp create_asset_files(year, day) do
    day_str = String.pad_leading("#{day}", 2, "0")

    files = [
      "final_input_1.txt",
      "final_input_2.txt"
    ]

    Enum.each(files, fn file ->
      File.write!("assets/year_#{year}/day_#{day_str}/#{file}", "")
    end)
  end
end
