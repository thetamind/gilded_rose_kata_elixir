Code.require_file "gilded_rose.ex", __DIR__
Code.require_file "gilded_rose_driver.ex", __DIR__

ExUnit.start seed: 0, trace: true

defmodule GildedRoseTest do
  use ExUnit.Case

  test "begin the journey of refactoring"

  test "cli output" do
    expected =
      File.read!(Path.expand("expected_stdout_test.txt", __DIR__))
      |> String.trim_trailing("\n")

    assert GildedRose.Driver.run(30) == expected
  end
end
