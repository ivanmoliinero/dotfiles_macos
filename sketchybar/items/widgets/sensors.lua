local constants = require("constants")
local settings = require("config.settings")

local cpu = sbar.add("item", constants.items.CPU, {
  position = "right",
  update_freq = 5,
  icon = { string = settings.icons.text.cpu },
  label = { string = "??% ??°" },
})

local gpu = sbar.add("item", constants.items.GPU, {
  position = "right",
  icon = { string = settings.icons.text.gpu },
  label = { string = "??% ??°" },
})

local ram = sbar.add("item", constants.items.RAM, {
  position = "right",
  icon = { string = settings.icons.text.ram },
  label = { string = "?.? GB" },
})

cpu:subscribe({ "routine", "forced", "system_woke" }, function()
  sbar.exec(
    "mactop --headless --count 1 2>/dev/null | jq -r '.[0] | \"\\(.cpu_usage) \\(.memory.used) \\(.memory.total) \\(.soc_metrics.cpu_temp) \\(.soc_metrics.gpu_temp) \\(.gpu_usage)\"'",
    function(result)
      local cpuPct, memUsed, memTotal, cpuT, gpuT, gpuPct =
        result:match("([%d.]+) ([%d.]+) ([%d.]+) ([%d.]+) ([%d.]+) ([%d.]+)")
      if cpuPct then
        cpu:set({ label = string.format("%.0f%% %.0f°", tonumber(cpuPct), tonumber(cpuT)) })
        gpu:set({ label = string.format("%.0f%% %.0f°", tonumber(gpuPct), tonumber(gpuT)) })
        ram:set({ label = string.format("%.1f GB", tonumber(memUsed) / 1073741824) })
      end
    end
  )
end)
