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
          day_01/
            commons.ex
            challenge_1.ex
            challenge_2.ex
      test/
        year_2015/
          day_01/
            challenge_1.exs
            challenge_2.exs
      assets/
        year_2015/
          day_01/
            sample_input_1.txt
            sample_input_2.txt
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
      "lib/year_#{year}/day_#{day_str}",
      "test/year_#{year}/day_#{day_str}",
      "assets/year_#{year}/day_#{day_str}"
    ]
    
    Enum.each(dirs, &File.mkdir_p!/1)
  end
  
  defp create_template_files(year, day) do
    day_str = String.pad_leading("#{day}", 2, "0")
    
    create_commons_file(year, day_str)
    create_challenge_files(year, day_str)
    create_test_files(year, day_str)
  end
  
  defp create_commons_file(year, day_str) do
    commons_content = """
    defmodule Year#{year}.Day#{day_str}.Commons do
      @moduledoc \"\"\"
      Common functions for Year #{year}, Day #{day_str}
      \"\"\"
    end
    """
    
    File.write!("lib/year_#{year}/day_#{day_str}/commons.ex", commons_content)
  end
  
  defp create_challenge_files(year, day_str) do
    Enum.each([1, 2], fn challenge ->
      challenge_content = """
      defmodule Year#{year}.Day#{day_str}.Challenge#{challenge} do
        @moduledoc \"\"\"
        Year #{year}, Day #{day_str}, Challenge #{challenge}
        \"\"\"
        
        def solve(input) do
          # Implement your solution here
          :none
        end
      end
      """
      
      File.write!("lib/year_#{year}/day_#{day_str}/challenge_#{challenge}.ex", challenge_content)
    end)
  end
  
  defp create_test_files(year, day_str) do
    Enum.each([1, 2], fn challenge ->
      test_content = """
      defmodule Year#{year}.Day#{day_str}.Challenge#{challenge}Test do
        use ExUnit.Case
        doctest Year#{year}.Day#{day_str}.Challenge#{challenge}
        
        test "works with sample input" do
          input = File.read!("assets/year_#{year}/day_#{day_str}/sample_input_#{challenge}.txt")
          assert Year#{year}.Day#{day_str}.Challenge#{challenge}.solve(input) == :none
        end
        
        test "works with final input" do
          input = File.read!("assets/year_#{year}/day_#{day_str}/final_input_#{challenge}.txt")
          assert Year#{year}.Day#{day_str}.Challenge#{challenge}.solve(input) == :none
        end
      end
      """
      
      File.write!("test/year_#{year}/day_#{day_str}/challenge_#{challenge}.exs", test_content)
    end)
  end
  
  defp create_asset_files(year, day) do
    day_str = String.pad_leading("#{day}", 2, "0")
    
    files = [
      "sample_input_1.txt",
      "sample_input_2.txt",
      "final_input_1.txt",
      "final_input_2.txt"
    ]
    
    Enum.each(files, fn file ->
      File.write!("assets/year_#{year}/day_#{day_str}/#{file}", "")
    end)
  end
end
