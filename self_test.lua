-- Development only, not required by control.lua for release.
-- Builds every entity the mod adds, in every direction, and logs the result.

local entities =
{
  "burner-generator",
  "big-burner-generator",
  "petroleum-generator",
  "oil-steam-boiler",
  "wind-turbine-2",
}

local technologies =
{
  "big-burner-generator",
  "petroleum-generator",
  "OilBurning",
}

local failed = 0

local report = function(str)
  log("[KS_Power self test] " .. str)
end

local fail = function(str)
  failed = failed + 1
  report("FAIL: " .. str)
end

local clear_area = function(surface, area)
  for k, entity in pairs (surface.find_entities_filtered{area = area, type = {"tree", "simple-entity", "cliff", "fish"}}) do
    entity.destroy()
  end
  surface.destroy_decoratives{area = area}
end

local test_entity = function(surface, name, x)
  local prototype = prototypes.entity[name]
  if not prototype then
    fail("no entity prototype " .. name)
    return
  end

  local area = {{x - 12, -12}, {x + 12, 12}}
  clear_area(surface, area)

  for k, direction in pairs {defines.direction.north, defines.direction.east, defines.direction.south, defines.direction.west} do
    local entity = surface.create_entity
    {
      name = name,
      position = {x, 0},
      direction = direction,
      force = "player",
      raise_built = true
    }
    if not entity then
      fail(name .. " could not be built facing " .. direction)
    else
      report(name .. " facing " .. direction ..
             " | fluidboxes " .. #prototype.fluidbox_prototypes ..
             " | max output " .. prototype.get_max_energy_production())
      entity.destroy()
    end
  end

  if not prototypes.item[name] then fail("no item prototype " .. name) end
  if not prototypes.recipe[name] then fail("no recipe prototype " .. name) end
end

local run_test = function()
  local surface = game.surfaces[1]
  local x = 0

  for k, name in pairs (entities) do
    test_entity(surface, name, x)
    x = x + 24
  end

  for k, name in pairs (technologies) do
    if not prototypes.technology[name] then fail("no technology prototype " .. name) end
  end

  if not prototypes.fluid["diesel-fuel"] then fail("no fluid prototype diesel-fuel") end

  local recipe = prototypes.recipe["diesel-fuel"]
  if not recipe then
    fail("no recipe prototype diesel-fuel")
  elseif not recipe.has_category("chemistry") then
    fail("diesel-fuel recipe is not in the chemistry category")
  else
    report("diesel-fuel recipe categories " .. serpent.line(recipe.categories))
  end

  for k, name in pairs {"crude-oil", "light-oil", "heavy-oil", "petroleum-gas", "diesel-fuel"} do
    local fluid = prototypes.fluid[name]
    if not fluid then
      fail("no fluid prototype " .. name)
    elseif not (fluid.fuel_value > 0) then
      fail(name .. " has no fuel value")
    else
      report(name .. " fuel value " .. fluid.fuel_value .. " emissions " .. fluid.emissions_multiplier)
    end
  end

  if failed == 0 then
    report("PASSED")
  else
    report("FAILED (" .. failed .. ")")
  end
end

script.on_event(defines.events.on_tick, function(event)
  if storage.self_test_done then return end
  storage.self_test_done = true
  run_test()
end)
