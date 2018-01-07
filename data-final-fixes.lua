local fuel_values = {
  ["light-oil"] = "3MJ",
  ["heavy-oil"] = "2MJ",
  ["petroleum-gas"] = "1MJ",
  ["diesel-fuel"] = "4MJ",
}

for k, fluid in pairs (data.raw.fluid) do
  if not fluid.fuel_value then
    fluid.fuel_value = fuel_values[fluid.name]
  end
end

for k, module in pairs(data.raw.module) do
  if module.effect and module.effect.productivity and module.limitation then
    for j, recipe in pairs({"diesel-fuel", "burn-heavy-oil", "burn-crude-oil", "burn-light-oil"}) do
      table.insert(module.limitation, recipe)
    end
  end
end
