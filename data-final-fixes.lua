local fuel_values = {
  ["light-oil"] = "3MJ",
  ["heavy-oil"] = "2MJ",
  ["petroleum-gas"] = "3MJ",
  ["diesel-fuel"] = "4MJ",
}

local emissions = {
  ["light-oil"] = 1.1,
  ["heavy-oil"] = 1.2,
  ["petroleum-gas"] = 1,
  ["diesel-fuel"] = 0.8,
}

local parse_energy = function(energy)
  local ending = energy:sub(energy:len())
  if not (ending == "J" or ending == "W") then
    error(ending.. " is not a valid unit of energy")
  end
  local magnitude = energy:sub(energy:len() - 1, energy:len() - 1)
  local multiplier = 1
  if type(magnitude) == "number" then
    return tonumber(energy:sub(1, energy:len()-1))
  end
  local char = {
    k = 1000,
    K = 1000,
    M = 1000000,
    G = 1000000000,
    T = 1000000000000,
    P = 1000000000000000,
    E = 1000000000000000000,
    Z = 1000000000000000000000,
    Y = 1000000000000000000000000
  }
  multiplier = char[magnitude]
  if not multiplier then error(magnitude.. " is not valid magnitude") end
  return tonumber(energy:sub(1, energy:len()-2)) * multiplier
end

local names = {}

for k, fluid in pairs (data.raw.fluid) do
  if not fluid.fuel_value then
    fluid.fuel_value = fuel_values[fluid.name]
  end
  if not fluid.emissions_multiplier then
    fluid.emissions_multiplier = emissions[fluid.name]
  end
  if fluid.fuel_value then 
    data:extend({
    {
      type = "recipe",
      name = "burn-"..fluid.name,
      energy_required = 1,
      enabled = "false",
      order = "c[fluid-chemistry]-"..fluid.order,
      category = "OilBurn",
      ingredients =
      {
        {type="fluid", name= "water", amount = 90},
        {type="fluid", name= fluid.name, amount = 3600000 / parse_energy(fluid.fuel_value)},
      },
      results =
      {
        {type="fluid", name="steam", amount=90, temperature = 165}

      },
      main_product= "",
      icons = {
        {icon = fluid.icon},
        {icon = "__KS_Power__/graphics/icons/fire-icon.png"},
      },
      icon_size = fluid.icon_size,
      subgroup = "oil-burning",
      emissions_multiplier = fluid.emissions_multiplier,
      localised_name = {"burn", fluid.localised_name or {"fluid-name."..fluid.name}}
    }
    })
    table.insert(names, "burn-"..fluid.name)
  end
end

local effects = {
{
  type = "unlock-recipe",
  recipe = "OilSteamBoiler"
}}

for k, name in pairs (names) do
  table.insert(effects,
  {
    type = "unlock-recipe",
    recipe = name
  })
end

data:extend({{
  type = "technology",
  name = "OilBurning",
  icon = "__KS_Power__/graphics/oil-boiler-tech2.png",
  icon_size = 128,
  effects = effects,
  prerequisites = {"oil-processing","concrete"},
  unit =
  {
    count = 200,
    ingredients =
    {
      {"science-pack-1", 1},
      {"science-pack-2", 1}
    },
    time = 30
  },
  order = "f-b-c",
}})

for k, module in pairs(data.raw.module) do
  if module.effect and module.effect.productivity and module.limitation then
    for j, recipe in pairs(names) do
      table.insert(module.limitation, recipe)
    end
  end
end
