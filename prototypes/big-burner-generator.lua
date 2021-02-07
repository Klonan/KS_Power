local burner_picture =
{
  layers =
  {
    {
      filename = "__KS_Power__/graphics/big-burner-generator/big-burner-generator.png",
      width = 320,
      height = 320,
      scale = 1,
      shift = { -0.03125, -0.1875 }
    },
    {
      filename = "__KS_Power__/graphics/big-burner-generator/big-burner-generator-shadow.png",
      width = 525,
      height = 323,
      scale = 1,
      shift = { 1.625, 0 },
      draw_as_shadow = true
    }
  }
}

local icon = "__KS_Power__/graphics/big-burner-generator/big-burner-generator.png"
local icon_size = 320

data:extend
{
  {
    type = "item",
    name = "big-burner-generator",
    icon = icon,
    icon_size = icon_size,
    flags = {},
    subgroup = "energy",
    order = "b[steam-power]-d[big-burner-generator]",
    place_result = "big-burner-generator",
    stack_size = 10
  },

  {
    type = "recipe",
    name = "big-burner-generator",
    enabled = false,
    ingredients =
    {
      {"heat-exchanger", 4},
      {"steel-plate", 50},
      {"concrete", 100},
      {"pump", 10}
    },
    result = "big-burner-generator"
  },
  {
    type = "burner-generator",
    name = "big-burner-generator",
    icon = icon,
    icon_size = icon_size,
    flags = {"placeable-neutral","player-creation"},
    minable = {mining_time = 1, result = "big-burner-generator"},
    max_health = 3000,
    corpse = "small-remnants",
    effectivity = 1,
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-4.2, -4.2}, {4.2, 4.2}},
    selection_box = {{-4.5, -4.5}, {4.5, 4.5}},
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-output"
    },
    burner =
    {
      type = "burner",
      fuel_inventory_size = 5,
      effectivity = 0.5,
      emissions_per_minute = 1000,
      light_flicker = {intensity = 1, minimum_light_size = 3, color = {r=1.0, g=1.0, b=0.5}},
      smoke =
      {
        {
          name = "smoke",
          frequency = 25,
          position = {-2.55, -1.4},
          deviation = {0.1,0.1},
          starting_vertical_speed = 0.1,
          starting_vertical_speed_deviation = 0.025,
          starting_frame_deviation = 3,
          slow_down_factor = 0.1
        },
        {
          name = "burner-generator-smoke",
          frequency = 180,
          position = {-2.55, -1.4},
          deviation = {0.1,0.1},
          starting_vertical_speed = 0.1,
          starting_vertical_speed_deviation = 0.025,
          starting_frame_deviation = 3,
          slow_down_factor = 0.1
        },
        {
          name = "burner-generator-smoke",
          frequency = 180,
          position = {-2.5, -1.4},
          deviation = {0.2,0.2},
          starting_vertical_speed = 0.1,
          starting_vertical_speed_deviation = 0.025,
          starting_frame_deviation = 3,
          slow_down_factor = 0.1
        }
      }
    },
    animation = burner_picture,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/steam-engine-90bpm.ogg",
        volume = 0.5
      },
      match_speed_to_activity = true,
    },
    min_perceived_performance = 0.25,
    performance_to_sound_speedup = 0.5,
    max_power_output = "50MW",
  },
}


data:extend
{
  {
    type = "technology",
    name = "big-burner-generator",
    icon = icon,
    icon_size = icon_size,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "big-burner-generator"
      }
    },
    prerequisites = {"flammables", "chemical-science-pack"},
    unit =
    {
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    order = "f-b-d",
  }
}