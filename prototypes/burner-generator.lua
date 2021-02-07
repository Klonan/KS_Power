require "util"
data:extend({

  {
    type = "item",
    name = "burner-generator",
    icon = "__KS_Power__/graphics/icons/burner-generator-icon.png",
    icon_size = 32,
    flags = {},
    subgroup = "energy",
    order = "b[steam-power]-c[burner-generator]",
    place_result = "burner-generator",
    stack_size = 10
  },

  {
    type = "recipe",
    name = "burner-generator",
    enabled = "true",
    ingredients =
    {
      {"boiler", 1},
      {"iron-plate", 4},
      {"iron-gear-wheel", 5},
      {"pipe", 4}
    },
    result = "burner-generator"
  },
  {
    type = "burner-generator",
    name = "burner-generator",
    icon = "__KS_Power__/graphics/icons/burner-generator-icon.png",
    icon_size = 32,
    flags = {"placeable-neutral","player-creation"},
    minable = {mining_time = 1, result = "burner-generator"},
    max_health = 300,
    corpse = "small-remnants",
    effectivity = 0.25,
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-1.2, -0.8}, {1.2, 0.8}},
    selection_box = {{-1.5, -1}, {1.5, 1}},
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-output"
    },
    burner =
    {
      type = "burner",
      fuel_inventory_size = 2,
      effectivity = 0.25,
      emissions_per_minute = 30,
      light_flicker = {intensity = 1, size = 0.5, color = {r=1.0, g=0.5, b=0}},
      smoke =
      {
        {
          name = "smoke",
          frequency = 10,
          --position = {0.05, 0.9},
          north_position = {0.05, 0.9},
          east_position = {0.05, 0.9},
          starting_vertical_speed = 0.05,
        },
        {
          name = "burner-generator-smoke",
          frequency = 60,
          --position = {0.05, 0.9},
          north_position = {0.05, 0.9},
          east_position = {0.05, 0.8},
          starting_vertical_speed = 0.05,
          starting_vertical_speed_deviation = 0.02,
          deviation = {0.1, 0.1}
        },
      }
    },
    animation =
    {
      north = 
      {
        layers =
        {
          {
            filename = "__KS_Power__/graphics/entity/burner-generator-h.png",
            priority = "extra-high",
            width = 121,
            height = 80,
            shift = util.by_pixel(20, 4),
            frame_count = 1
          },
          --{
          --  filename = "__KS_Power__/graphics/entity/boiler-fire-down.png",
          --  priority = "extra-high",
          --  line_length = 8,
          --  width = 21,
          --  height = 34,
          --  frame_count = 48,
          --  axially_symmetrical = false,
          --  direction_count = 1,
          --  shift = util.by_pixel(5,17)
          --}
        }
      },
      east = 
      {
        layers = 
        {
          {
            filename = "__KS_Power__/graphics/entity/burner-generator-v.png",
            priority = "extra-high",
            width = 93,
            height = 112,
            shift = util.by_pixel(12, -0.5),
            frame_count = 1,
          }
        }
      }
    },
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
    max_power_output = "0.5MW",
  },

}
)

data:extend(
{
  {
    type = "trivial-smoke",
    name = "burner-generator-smoke",
    flags = {"not-on-map"},
    duration = 100,
    fade_in_duration = 0,
    fade_away_duration = 20,
    spread_duration = 200,
    slow_down_factor = 0.5,
    start_scale = 1,
    end_scale = 0,
    color = {r = 1, g = 1, b = 1, a = 1},
    cyclic = false,
    affected_by_wind = true,
    animation =
    {
      filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
      priority = "extra-high",
      width = 64,
      height = 64,
      frame_count = 32,
      line_length = 8,
      scale = 0.25,
      animation_speed = 32 / 100,
      blend_mode = "additive"
    },
  },
})