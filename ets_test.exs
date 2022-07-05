# setup ETS
table = :ets.new(:address_book, [:set, :protected, :named_table])

# Setup ETS data
phones = Enum.map(1..100_000, fn _n -> Faker.Phone.PtBr.phone() end)

Enum.each(phones, fn phone ->
  :ets.insert(
    table,
    {phone,
     %{
       name: Faker.Person.first_name(),
       address: Faker.Address.street_address(),
       country_code: Enum.random([55, 34]),
       number: Enum.random(1..909)
     }}
  )
end)

# scenario 1: without keys
# Benchee.run(
#   %{
#     "match_object" => fn -> :ets.match_object(table, {:_, %{number: 101}}) end,
#     "select" => fn ->
#       :ets.select(table, [{{:_, %{number: :"$1"}}, [{:==, :"$1", 101}], [:"$_"]}])
#     end
#   },
#   warmup: 0,
#   time: 5,
#   formatters: [
#     {Benchee.Formatters.HTML, file: "benchmarks/output/1_without_keys.html"},
#     Benchee.Formatters.Console
#   ]
# )

# scenario 2: with keys
# random_phone = Enum.random(phones)

# Benchee.run(
#   %{
#     "match_object" => fn -> :ets.match_object(table, {random_phone, :_}) end,
#     "select" => fn ->
#       :ets.select(table, [{{random_phone, :_}, [], [:"$_"]}])
#     end
#   },
#   warmup: 0,
#   time: 5,
#   formatters: [
#     {Benchee.Formatters.HTML, file: "benchmarks/output/2_with_keys.html"},
#     Benchee.Formatters.Console
#   ]
# )

# # scenario 3: without keys but with some more complex condition
# Benchee.run(
#   %{
#     "match_object" => fn ->
#       table
#       |> :ets.match_object({:_, %{number: :"$1"}})
#       |> Enum.filter(fn {_key, value} -> value.number >= 101 end)
#     end,
#     "select" => fn ->
#       :ets.select(table, [{{:_, %{number: :"$1"}}, [{:>=, :"$1", 101}], [:"$_"]}])
#     end
#   },
#   warmup: 0,
#   time: 5,
#   formatters: [
#     {Benchee.Formatters.HTML, file: "benchmarks/output/3_no_keys_but_complex.html"},
#     Benchee.Formatters.Console
#   ]
# )
