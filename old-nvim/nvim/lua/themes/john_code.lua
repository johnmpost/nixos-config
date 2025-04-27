-- this line for types, by hovering and autocompletion (lsp required)
-- will help you understanding properties, fields, and what highlightings the color used for
---@type Base46Table
---@diagnostic disable-next-line: unused-local, missing-fields
local M = {}

M.base_30 = {
  white = "#dee1e6",
  darker_black = "#1a1a1a",
  black = "#1E1E1E", --  nvim bg
  black2 = "#252525",
  one_bg = "#282828",
  one_bg2 = "#313131",
  one_bg3 = "#3a3a3a",
  grey = "#444444",
  grey_fg = "#4e4e4e",
  grey_fg2 = "#585858",
  light_grey = "#626262",
  red = "#D16969",
  baby_pink = "#ea696f",
  pink = "#bb7cb6",
  line = "#2e2e2e", -- for lines like vertsplit
  green = "#B5CEA8",
  green1 = "#4EC994",
  vibrant_green = "#bfd8b2",
  blue = "#428ecd",
  nord_blue = "#60a6e0",
  yellow = "#D7BA7D",
  sun = "#e1c487",
  purple = "#c68aee",
  dark_purple = "#c788d0",
  teal = "#55bdf3",
  orange = "#d3967d",
  cyan = "#9CDCFE",
  statusline_bg = "#242424",
  lightbg = "#303030",
  pmenu_bg = "#60a6e0",
  folder_bg = "#7A8A92",
}

M.base_16 = {
  base00 = "#1E1E1E", -- Default Background
  base01 = "#262626", -- Lighter Background (Used for status bars, line number and folding marks)
  base02 = "#303030", -- Selection Background
  base03 = "#3C3C3C", -- Comments, Invisibles, Line Highlighting
  base04 = "#464646", -- Dark Foreground (Used for status bars)
  base05 = "#D4D4D4", -- Default Foreground, Caret, Delimiters, Operators
  base06 = "#E9E9E9", -- Light Foreground (Not often used)
  base07 = "#FFFFFF", -- Light Background (Not often used)
  base08 = M.base_30.teal, -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
  base09 = "#B5CEA8", -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
  base0A = "#66cdaa", -- Classes, Markup Bold, Search Text Background
  base0B = "#BD8D78", -- Strings, Inherited Class, Markup Code, Diff Inserted
  base0C = M.base_30.blue, -- Support, Regular Expressions, Escape Characters, Markup Quotes
  base0D = "#DCDCAA", -- Functions, Methods, Attribute IDs, Headings
  base0E = M.base_30.blue, -- Keywords, Storage, Selector, Markup Italic, Diff Changed
  base0F = "#ffdd00", -- Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
}

M.polish_hl = {
  treesitter = {
    ["@variable.parameter"] = { fg = M.base_30.cyan },
    ["@variable"] = { fg = M.base_30.teal },
    ["@variable.member"] = { fg = M.base_30.cyan },
    ["@keyword"] = { fg = M.base_30.blue },
    ["@keyword.conditional.ternary"] = { fg = M.base_30.white },
    ["@punctuation.delimiter"] = { fg = M.base_30.white },
    ["Include"] = { fg = M.base_30.dark_purple },
    ["@keyword.return"] = { fg = M.base_30.dark_purple },
    ["@keyword.exception"] = { fg = M.base_30.dark_purple },
    ["@boolean"] = { fg = M.base_30.blue },
  },
}

-- set the theme type whether is dark or light
M.type = "dark"

-- this will be later used for users to override your theme table from chadrc
M = require("base46").override_theme(M, "john_code")

return M
