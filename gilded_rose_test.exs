Code.require_file "gilded_rose.ex", __DIR__
Code.require_file "gilded_rose_driver.ex", __DIR__

ExUnit.start seed: 0, trace: true

defmodule GildedRoseTest do
  use ExUnit.Case

  test "cli output" do
    expected =
      File.read!(Path.expand("expected_stdout_test.txt", __DIR__))
      |> String.trim_trailing("\n")

    assert GildedRose.Driver.run(30) == expected
  end

  describe "quality" do
    test "degrades by one" do
      item = generic_item(quality: 20)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 19
    end

    test "degrades by two after sell by date" do
      item = generic_item(sell_in: -5, quality: 20)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 18
    end

    test "never becomes negative" do
      item = generic_item(quality: 0)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 0
    end

    test "never becomes more than 50" do
      item = aged_brie(quality: 50)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 50
    end
  end

  defp generic_item(opts) do
    %Item{
      name: Keyword.get(opts, :name, "Generic Item"),
      sell_in: Keyword.get(opts, :sell_in, 10),
      quality: Keyword.get(opts, :quality, 20)
    }
  end

  defp aged_brie(opts) do
    generic_item(Keyword.put(opts, :name, "Aged Brie"))
  end
end
