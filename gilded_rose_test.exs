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

  describe "generic item" do
    test "quality degrades by one" do
      item = generic_item(quality: 20)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 19
    end

    test "quality degrades by two after sell by date" do
      item = generic_item(sell_in: -5, quality: 20)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 18
    end

    test "quality never becomes negative" do
      item = generic_item(quality: 0)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 0
    end
  end

  describe "Aged Brie" do
    test "quality increases" do
      item = aged_brie(quality: 30)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 31
    end

    test "quality increases by two after sell date" do
      item = aged_brie(sell_in: -5, quality: 30)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 32
    end

    test "quality never becomes more than 50" do
      item = aged_brie(quality: 50)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 50
    end
  end

  describe "Sulfuras" do
    test "quality is always 80" do
      item = sulfuras()
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 80
    end

    test "sell date never changes" do
      item = sulfuras(sell_in: 10)
      next_item = GildedRose.update_item(item)
      assert next_item.sell_in == 10
    end
  end

  describe "Backstage Passes" do
    test "quality increases" do
      item = backstage_passes(sell_in: 15, quality: 30)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 31
    end

    test "quality increases by 2 when 10 days or less" do
      item = backstage_passes(sell_in: 10, quality: 30)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 32
    end

    test "quality increases by 3 when 5 days or less" do
      item = backstage_passes(sell_in: 5, quality: 30)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 33
    end

    test "quality is 0 when expired" do
      item = backstage_passes(sell_in: 0, quality: 30)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 0
    end
  end

  describe "Conjured item" do
    test "quality degrades by two" do
      item = conjured(quality: 20)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 18
    end

    test "quality degrades by four after sell by date" do
      item = conjured(sell_in: -5, quality: 20)
      next_item = GildedRose.update_item(item)
      assert next_item.quality == 16
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

  defp sulfuras(opts \\ []) do
    opts
    |> Keyword.put(:name, "Sulfuras, Hand of Ragnaros")
    |> Keyword.put(:quality, 80)
    |> generic_item()
  end

  defp backstage_passes(opts) do
    generic_item(Keyword.put(opts, :name, "Backstage passes to a TAFKAL80ETC concert"))
  end

  defp conjured(opts) do
    generic_item(Keyword.put(opts, :name, "Conjured Mana Cake"))
  end
end
