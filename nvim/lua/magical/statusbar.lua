_G.status_mood = "^ this is fine"

function _G.get_status_mood()
  return _G.status_mood or ""
end

function _G.lsp_diagnostics()
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warns  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN  })
    local hints  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT  })
    local info   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO  })

    local result = ""

    if errors > 0 then
      result = result .. " E:" .. errors
    end
    if warns > 0 then
      result = result .. " W:" .. warns
    end
    if hints > 0 then
      result = result .. " H:" .. hints
    end
    if info > 0 then
      result = result .. " I:" .. info
    end

    return result
end

function _G.file_size()
  local size = vim.fn.getfsize(vim.fn.expand("%:p"))
  if size < 0 then return "" end
  return string.format("%.1fKB", size / 1024)
end

vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
      vim.cmd("redrawstatus")
    end,
})

-- vim.o.statusline = " %f %M %h%r %= %{v:lua.lsp_diagnostics()} %c %p%% "

vim.o.statusline =
  " %{mode()} " ..
  "%f " ..
  "%{v:lua.file_size()} " ..
  "%M %h%r " ..
  "%= " ..
  "%{v:lua.get_status_mood()}" ..
  "%= " ..
  "%Y " ..
  "%{v:lua.lsp_diagnostics()}" ..
  "%c %p%% "
