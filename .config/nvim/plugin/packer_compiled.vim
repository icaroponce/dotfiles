" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/icaro/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/icaro/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/icaro/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/icaro/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/icaro/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    commands = { "MarkdownPreview" },
    loaded = false,
    needs_bufread = false,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspfuzzy"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/nvim-lspfuzzy"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  tabular = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-css-color"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-css-color"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-expand-region"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-expand-region"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-highlightedyank"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-highlightedyank"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-markdown"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/icaro/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  }
}

time([[Defining packer_plugins]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
vim.cmd [[command! -nargs=* -range -bang -complete=file MarkdownPreview lua require("packer.load")({'markdown-preview.nvim'}, { cmd = "MarkdownPreview", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
