# Gilded Rose Refactoring Kata

My implementation of the [Gilded Rose Kata][kata] in Elixir.

How did I refactor a stream of conditionals [nested](gilded_rose.ex@baf5972) nearly to infinity − 1?

Items are pattern matched on `name` in the function heads with guards on `sell_in`. This works well for special items; falling through to default behaviour for generic items.

```elixir
def update_item(%Item{name: "Aged Brie", sell_in: sell_in} = item) when sell_in <= 0 do
```

Mutation of items are handled by composing single-purpose mutators.

```elixir
item |> age() |> degrade(4)
```

## Tests

Execute the tests:

```
$ elixir guilded_rose_test.exs
```

Unit tests were written based on the specification in the [requirements document](guilded_rose_requirements.txt). They are not exhaustive. For example, the minimum quality limit is only checked for generic items.

There is one acceptance test matching the expected output provided for [TextTest][texttest]. Rather than attempt to install TextTest I wrote a [simple driver](gilded_rose_driver.ex) that generates the report.



[kata]: https://github.com/emilybache/GildedRose-Refactoring-Kata
[texttest]: https://github.com/emilybache/GildedRose-Refactoring-Kata/tree/master/texttests
