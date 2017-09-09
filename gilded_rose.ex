defmodule Item do
  defstruct name: nil, sell_in: nil, quality: nil
end

defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  @backstage "Backstage passes to a TAFKAL80ETC concert"

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(%Item{name: "Aged Brie", sell_in: sell_in} = item) when sell_in <= 0 do
    item |> age() |> improve(2)
  end

  def update_item(%Item{name: "Aged Brie"} = item) do
    item |> age() |> improve(1)
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item) do
    item
  end

  def update_item(%Item{name: @backstage, sell_in: sell_in} = item) when sell_in <= 0 do
    %Item{item | sell_in: sell_in - 1, quality: 0}
  end

  def update_item(%Item{name: @backstage, sell_in: sell_in} = item) when sell_in <= 5 do
    item |> age() |> improve(3)
  end

  def update_item(%Item{name: @backstage, sell_in: sell_in} = item) when sell_in <= 10 do
    item |> age() |> improve(2)
  end

  def update_item(%Item{name: @backstage} = item) do
    item |> age() |> improve(1)
  end

  def update_item(%Item{name: "Conjured Mana Cake", sell_in: sell_in} = item) when sell_in <= 0 do
    item |> age() |> degrade(4)
  end

  def update_item(%Item{name: "Conjured Mana Cake"} = item) do
    item |> age() |> degrade(2)
  end

  def update_item(%Item{sell_in: sell_in} = item) when sell_in <= 0 do
    item |> age() |> degrade(2)
  end

  def update_item(%Item{} = item) do
    item |> age() |> degrade(1)
  end

  # Helpers

  defp age(%Item{} = item) do
    %Item{item | sell_in: item.sell_in - 1}
  end

  defp degrade(%Item{} = item, rate) do
    %Item{item | quality: max(item.quality - rate, 0)}
  end

  defp improve(%Item{} = item, rate) do
    %Item{item | quality: min(item.quality + rate, 50)}
  end
end
