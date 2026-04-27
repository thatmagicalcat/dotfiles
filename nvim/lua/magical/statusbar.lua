_G.status_mood = "^ this is fine"

local diagnostics_cache = {}
local file_size_cache = {}

local function build_diagnostics(bufnr)
    local counts = {
        [vim.diagnostic.severity.ERROR] = 0,
        [vim.diagnostic.severity.WARN] = 0,
        [vim.diagnostic.severity.HINT] = 0,
        [vim.diagnostic.severity.INFO] = 0,
    }

    for _, diagnostic in ipairs(vim.diagnostic.get(bufnr)) do
        counts[diagnostic.severity] = (counts[diagnostic.severity] or 0) + 1
    end

    local result = ""

    if counts[vim.diagnostic.severity.ERROR] > 0 then
        result = result .. " E:" .. counts[vim.diagnostic.severity.ERROR]
    end
    if counts[vim.diagnostic.severity.WARN] > 0 then
        result = result .. " W:" .. counts[vim.diagnostic.severity.WARN]
    end
    if counts[vim.diagnostic.severity.HINT] > 0 then
        result = result .. " H:" .. counts[vim.diagnostic.severity.HINT]
    end
    if counts[vim.diagnostic.severity.INFO] > 0 then
        result = result .. " I:" .. counts[vim.diagnostic.severity.INFO]
    end

    if result == "" then
        return ""
    end

    return "[" .. string.sub(result, 2) .. "]"
end

local function refresh_diagnostics(bufnr)
    diagnostics_cache[bufnr] = build_diagnostics(bufnr)
end

local function build_file_size(bufnr)
    local path = vim.api.nvim_buf_get_name(bufnr)
    if path == "" then
        return ""
    end

    local size = vim.fn.getfsize(path)
    if size < 0 then
        return ""
    end

    return string.format("%.1fKB", size / 1024)
end

local function refresh_file_size(bufnr)
    file_size_cache[bufnr] = build_file_size(bufnr)
end

function _G.get_status_mood()
  return _G.status_mood or ""
end

function _G.lsp_diagnostics()
    local bufnr = vim.api.nvim_get_current_buf()
    if diagnostics_cache[bufnr] == nil then
        refresh_diagnostics(bufnr)
    end

    return diagnostics_cache[bufnr]
end

function _G.file_size()
    local bufnr = vim.api.nvim_get_current_buf()
    if file_size_cache[bufnr] == nil then
        refresh_file_size(bufnr)
    end

    return file_size_cache[bufnr]
end

vim.api.nvim_create_autocmd({ "DiagnosticChanged", "BufEnter" }, {
    callback = function(ev)
        local bufnr = ev.buf or vim.api.nvim_get_current_buf()
        refresh_diagnostics(bufnr)
        vim.cmd("redrawstatus")
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "BufFilePost" }, {
    callback = function(ev)
        local bufnr = ev.buf or vim.api.nvim_get_current_buf()
        refresh_file_size(bufnr)
        vim.cmd("redrawstatus")
    end,
})

vim.api.nvim_create_autocmd("BufWipeout", {
    callback = function(ev)
        diagnostics_cache[ev.buf] = nil
        file_size_cache[ev.buf] = nil
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
  "%{v:lua.lsp_diagnostics()} " ..
  "%c %p%% "
