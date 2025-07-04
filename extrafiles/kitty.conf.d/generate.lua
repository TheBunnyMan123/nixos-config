local function writeFile(file, text)
  local f = assert(io.open("/etc/nixos/extrafiles/kitty.conf.d/" .. file, "w"))
  f:write(text)
  f:close()
end

function math.clamp(val, min, max)
  if val < min then
    return min
  elseif val > max then
    return max
  else
    return val
  end
end

function insertmany(tbl, ...)
  for _, v in pairs({...}) do
    table.insert(tbl, v)
  end
end

-- Colors
local function getColor(rgb)
  local r = string.format("%x", math.floor(0.5 + rgb.r))
  local g = string.format("%x", math.floor(0.5 + rgb.g))
  local b = string.format("%x", math.floor(0.5 + rgb.b))

  if #r == 1 then r = "0" .. r end
  if #g == 1 then g = "0" .. g end
  if #b == 1 then b = "0" .. b end

  return "#" .. r .. g .. b
end
local function rgb(r, g, b)
  return setmetatable({
    r = r,
    g = g,
    b = b
  }, {
    __div = function(a, b)
      return rgb(a.r / b, a.g / b, a.b / b)
    end,
    __add = function(a, b)
      return rgb(a.r + b.r, a.g + b.g, a.b + b.b)
    end,
    __sub = function(a, b)
      return rgb(a.r - b.r, a.g - b.g, a.b - b.b)
    end
  })
end
local function hex(hex)
  local r, g, b = hex:match("#(%x%x)(%x%x)(%x%x)")

  return rgb(tonumber("0x" .. r), tonumber("0x" .. g), tonumber("0x" .. b))
end

local colors = {
  hex("#46425e");
  hex("#d67782");
  hex("#6bffa4");
  hex("#ea9971");
  hex("#a7cfeb");
  hex("#ff63a2");
  hex("#00b9be");
  hex("#8e9cb3");
  hex("#70749d");
  hex("#ff6973");
  hex("#c2ffa6");
  hex("#ebbd8c");
  hex("#9dbae3");
  hex("#ff90b7");
  hex("#b3e0f2");
  hex("#e6d3b9");
}
local extracolors = {
  mark1_foreground = hex("#1e1e2e");
  mark1_background = hex("#b4befe");
  mark2_foreground = hex("#1e1e2e");
  mark2_background = hex("#cba6f7");
  mark3_foreground = hex("#1e1e2e");
  mark3_background = hex("#74c7ec");
}

local iter = 0
local function gradient(col1, col2, steps)
  steps = steps or 6
  col1 = rgb(col1.r, col1.g, col1.b)
  col2 = rgb(col2.r, col2.g, col2.b)

  local delta = (col2 - col1) / (steps-1)
  local final = {}

  print(delta.r, delta.g, delta.b)

  for i = 0, steps-1 do
    local dlta = rgb(delta.r * i, delta.g * i, delta.b * i)
    table.insert(final, col1 + dlta)
  end

  return final
end
local function boxgradient(col1, col2, col3, col4)
  local column1 = gradient(col1, col2)
  local column2 = gradient(col3, col4)

  for y = 1, 6 do
    local row = gradient(column1[y], column2[y])

    for x = 1, 6 do
      table.insert(colors, row[x])
    end
  end
end

local c1 = gradient(colors[1], colors[10])
local c2 = gradient(colors[11], colors[12])
local c3 = gradient(colors[5], colors[14])
local c4 = gradient(colors[15], colors[16])

boxgradient(c1[1], c2[1], c3[1], c4[1])
boxgradient(c1[2], c2[2], c3[2], c4[2])
boxgradient(c1[3], c2[3], c3[3], c4[3])
boxgradient(c1[4], c2[4], c3[4], c4[4])
boxgradient(c1[5], c2[5], c3[5], c4[5])
boxgradient(c1[6], c2[6], c3[6], c4[6])

for _, v in pairs(gradient(colors[1], colors[16], 24)) do
  table.insert(colors, v)
end

local finalColorsText = ""
for k, v in pairs(colors) do
  finalColorsText = finalColorsText .. "color" .. (k-1) .. " " .. getColor(v) .. "\n"
end
for k, v in pairs(extracolors) do
  finalColorsText = finalColorsText .. k .. " " .. getColor(v) .. "\n"
end
writeFile("colors.conf", finalColorsText)

