defmodule GildedRose.Driver do
  def run(days) do
    items = [
      %Item{name: "+5 Dexterity Vest", sell_in: 10, quality: 20},
      %Item{name: "Aged Brie", sell_in: 2, quality: 0},
      %Item{name: "Elixir of the Mongoose", sell_in: 5, quality: 7},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80},
      %Item{name: "Sulfuras, Hand of Ragnaros", sell_in: -1, quality: 80},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 49},
      %Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 49},
      %Item{name: "Conjured Mana Cake", sell_in: 3, quality: 6}
    ]

    items
    |> age_items(days)
    |> report_with_greeting()
  end

  def age_items(items, days) do
    Enum.reduce(0..(days - 1), [items], fn _day, [items | tail] ->
      next = GildedRose.update_quality(items)
      [next, items | tail]
    end)
    |> Enum.reverse()
  end

  def report_with_greeting(aged_items) do
    "OMGHAI!\n" <> report(aged_items)
  end

  def report(aged_items) do
    aged_items
    |> Enum.with_index(0)
    |> Enum.map(fn {items, day} ->
      report_day(items, day)
    end)
    |> Enum.join("\n\n")
  end

  def report_day(items, day) do
    header = """
    -------- day #{day} --------
    name, sellIn, quality
    """

    body = Enum.map(items, fn item ->
      "#{item.name}, #{item.sell_in}, #{item.quality}"
    end)
    |> Enum.join("\n")

    header <> body
  end
end
