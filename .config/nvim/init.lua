local function ensure(pkg)
  local pkg_name = pkg:match "[^/]*$"
  local pkg_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/" .. pkg_name
  if vim.fn.empty(vim.fn.glob(pkg_path)) > 0 then
    vim.pretty_print(("Installing %s to %s"):format(pkg, pkg_path))
    vim.fn.system { "git", "clone", "https://github.com/" .. pkg, pkg_path }
    vim.cmd("packadd " .. pkg_name)
  end
end

ensure "wbthomason/packer.nvim"

require "options"
require "packages"
require "mappings"
