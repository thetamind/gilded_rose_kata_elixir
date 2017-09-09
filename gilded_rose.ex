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
    %Item{item | sell_in: sell_in - 1, quality: min(item.quality + 2, 50)}
  end

  def update_item(%Item{name: "Aged Brie", sell_in: sell_in} = item) do
    %Item{item | sell_in: sell_in - 1, quality: min(item.quality + 1, 50)}
  end

  def update_item(%Item{name: "Sulfuras, Hand of Ragnaros"} = item) do
    item
  end

  def update_item(%Item{name: @backstage, sell_in: sell_in} = item) when sell_in <= 0 do
    %Item{item | sell_in: sell_in - 1, quality: 0}
  end

  def update_item(%Item{name: @backstage, sell_in: sell_in} = item) when sell_in <= 5 do
    %Item{item | sell_in: sell_in - 1, quality: min(item.quality + 3, 50)}
  end

  def update_item(%Item{name: @backstage, sell_in: sell_in} = item) when sell_in <= 10 do
    %Item{item | sell_in: sell_in - 1, quality: min(item.quality + 2, 50)}
  end

  def update_item(%Item{name: @backstage, sell_in: sell_in} = item) do
    %Item{item | sell_in: sell_in - 1, quality: min(item.quality + 1, 50)}
  end

  def update_item(item) do
    item = if item.quality > 0 do
      %{item | quality: item.quality - 1}
    else
      item
    end

    item = %{item | sell_in: item.sell_in - 1}

    cond do
      item.sell_in < 0 ->
        cond do
          item.quality > 0 ->
            %{item | quality: item.quality - 1}
          true -> item
        end
      true -> item
    end
  end
end
