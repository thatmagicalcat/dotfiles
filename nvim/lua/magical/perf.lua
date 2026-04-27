local insert_perf_group = vim.api.nvim_create_augroup("magical-insert-perf", { clear = true })
local inlay_hint_state = {}
local ibl_state = {}

local function set_inlay_hints(enabled, bufnr)
    if not vim.lsp.inlay_hint or not vim.lsp.inlay_hint.enable then
        return
    end

    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_is_valid(bufnr) then
        vim.lsp.inlay_hint.enable(enabled, { bufnr = bufnr })
    end
end

local function inlay_hints_enabled(bufnr)
    if not vim.lsp.inlay_hint or not vim.lsp.inlay_hint.is_enabled then
        return false
    end

    return vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
end

local function set_ibl(enabled, bufnr)
    local ok, ibl = pcall(require, "ibl")
    if not ok or type(ibl.setup_buffer) ~= "function" then
        return
    end

    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_is_valid(bufnr) then
        ibl.setup_buffer(bufnr, { enabled = enabled })
    end
end

local function ibl_enabled(bufnr)
    local ok, conf = pcall(require, "ibl.config")
    if not ok or type(conf.get_config) ~= "function" then
        return false
    end

    return conf.get_config(bufnr).enabled
end

vim.api.nvim_create_autocmd("InsertEnter", {
    group = insert_perf_group,
    callback = function(ev)
        local bufnr = ev.buf or vim.api.nvim_get_current_buf()

        inlay_hint_state[bufnr] = inlay_hints_enabled(bufnr)
        ibl_state[bufnr] = ibl_enabled(bufnr)

        if inlay_hint_state[bufnr] then
            set_inlay_hints(false, bufnr)
        end

        if ibl_state[bufnr] then
            set_ibl(false, bufnr)
        end
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    group = insert_perf_group,
    callback = function(ev)
        local bufnr = ev.buf or vim.api.nvim_get_current_buf()

        if inlay_hint_state[bufnr] then
            set_inlay_hints(true, bufnr)
        end

        if ibl_state[bufnr] then
            set_ibl(true, bufnr)
        end

        inlay_hint_state[bufnr] = nil
        ibl_state[bufnr] = nil
    end,
})
