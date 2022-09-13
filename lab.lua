local mod_gui = require("mod-gui")
local util = require("util")
local version = 1

local on_player_created = function(event)
  local player = game.players[event.player_index]
  local character = player.character
  player.character = nil
  if character then
    character.destroy()
  end

  local r = global.chart_distance or 200
  player.force.chart(player.surface, {{player.position.x - r, player.position.y - r}, {player.position.x + r, player.position.y + r}})

  player.force.research_all_technologies()
  player.cheat_mode = true
  player.surface.always_day = true
  util.insert_safe(player, {
    ["electric-energy-interface"] = 1,
    ["infinity-chest"] = 10,
    ["infinity-pipe"] = 10,

    ["construction-robot"] = 100,
    ["roboport"] = 10,

    ["big-electric-pole"] = 50,
    ["medium-electric-pole"] = 50,

    ["express-transport-belt"] = 500,
    ["express-underground-belt"] = 200,
    ["express-splitter"] = 200,

    ["fast-transport-belt"] = 100,
    ["fast-underground-belt"] = 50,
    ["fast-splitter"] = 50,

    ["stack-inserter"] = 200,
    ["long-handed-inserter"] = 100,
    ["fast-inserter"] = 50,
    ["filter-inserter"] = 50,

    ["pipe"] = 100,
    ["pipe-to-ground"] = 100,

    ["assembling-machine-3"] = 50,

    ["arithmetic-combinator"] = 50,
    ["decider-combinator"] = 50,
    ["green-wire"] = 50,
    ["red-wire"] = 50,

    ["rail"] = 1000,
    ["rail-signal"] = 150,
    ["rail-chain-signal"] = 50,
    ["train-stop"] = 10,
    ["locomotive"] = 5,
    ["cargo-wagon"] = 5,
    ["fluid-wagon"] = 5,

    ["productivity-module-3"] = 100,
    ["speed-module-3"] = 300,
    ["beacon"] = 50,

    ["requester-chest"] = 10,
    ["buffer-chest"] = 10,
    ["active-provider-chest"] = 10,
    ["storaga-chest"] = 10,
  })
  if game.active_mods["Krastorio2"] then
    util.insert_safe(player, {
      ["kr-large-roboport"] = 1,
      ["kr-express-loader"] = 50,
      ["kr-fast-loader"] = 50,
      ["kr-electric-mining-drill-mk2"] = 50,
      ["kr-fluid-storage-2"] = 50,
    })
  else
    util.insert_safe(player, {
      ["electric-mining-drill"] = 50,
    })
  end
  if game.active_mods["holographic_signs"] then
    util.insert_safe(player, {
      ["hs_holo_sign"] = 50,
    })
  end
end

local sandbox = {}

sandbox.events =
{
  [defines.events.on_player_created] = on_player_created
}

sandbox.on_init = function()
  global.version = version
end

sandbox.on_configuration_changed = function(event)
end

sandbox.add_remote_interface = function()
  remote.add_interface("sandbox",
  {
    set_skip_intro = function(bool)
      global.skip_intro = true
    end,
    set_chart_distance = function(value)
      global.chart_distance = tonumber(value) or error("Remote call parameter to sandbox set chart distance must be a number")
    end
  })
end

return sandbox
