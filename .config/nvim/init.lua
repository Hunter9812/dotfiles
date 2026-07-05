local home = os.getenv("HOME") or os.getenv("USERPROFILE")
local platform = dofile(home .. "/.config/lua/platform.lua")

vim.loader.enable()
require("config.essentials")
require("config.lazy")

if vim.g.neovide then
  require("config.neovide")
end

if platform.is_windows() then
  -- fixme: 我发现 pwsh 有问题是因为 yazi.nvim 每次打开都会崩溃，后来我找到了下面的设置，但是在嵌套打开时还是会崩溃，作者并没有 Windows 测试环境，感觉难办了
  -- https://github.com/mikavilpas/yazi.nvim/issues/675
  -- https://github.com/neovim/neovim/issues/13893#issuecomment-1715634904
  -- :help shell-powershell
  if vim.env.SHELL == "pwsh" then
    vim.opt.shelltemp = false
    vim.opt.shell = 'pwsh'
    vim.opt.shellcmdflag =
      '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
      .. '[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();'
      .. "$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
      .. "$PSStyle.OutputRendering = 'PlainText';"
    vim.opt.shellquote = ""
    vim.opt.shellxquote = ""
    vim.env.__SuppressAnsiEscapeSequences = 1
  end
end
