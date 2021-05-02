local gl = require('galaxyline')
local gls = gl.section
local vcs = require('galaxyline.provider_vcs')

local colors = {
    bg = '#282a36',
    fg = '#f8f8f2',
    section_bg = '#38393f',
    yellow = '#f1fa8c',
    cyan = '#8be9fd',
    green = '#50fa7b',
    orange = '#ffb86c',
    magenta = '#ff79c6',
    blue = '#8be9fd',
    red = '#ff5555'
}

local icons = {
    lock = '',
    unsaved = '',
    -- Os
    linux = '',
    android = '',
    mac = '',
    windows = '',
    -- Github
    github = '',
    git_branch = '',
    -- Signs
    lsp_error = '',
    lsp_warn = '',
    lsp_info = '',
    lsp_hint = ''
}


local diagnostics_icons = {
    icons.lsp_error,
    icons.lsp_warn,
    icons.lsp_info,
    icons.lsp_hint
}

local function get_line_main_diagnostic()
    local diagnostics = vim.lsp.diagnostic.get_line_diagnostics()
    if (#diagnostics == 0) then return nil end
    table.sort(diagnostics, function(a, b) return a.severity < b.severity end)
    return diagnostics[1]
end

local function get_formated_line_main_diagnostic()
    local diagnostic = get_line_main_diagnostic()
    if (diagnostic == nil) then return nil end

    local main_icon = diagnostics_icons[diagnostic.severity]

    return ' '..main_icon..' '..diagnostic.message
end

local function in_git_repo()
    local branch_name = vcs.get_git_branch()
    return branch_name ~= nil
end

local function get_mode_name()
    local alias = {
        n = 'NORMAL',
        t = 'TERMINAL',
        i = 'INSERT',
        c = 'SEARCH',
        v = 'VISUAL',
        V = 'VISUAL L',
        [''] = 'VISUAL B',
        R = 'REPLACE',
    }
    return alias[vim.fn.mode()] or vim.fn.mode()..' MODE'
end

gls.left = {{
    FirstElement = {
        provider = function() return '▋' end,
        highlight = { colors.cyan, colors.section_bg }
    },
}, {
    ViMode = {
        provider = get_mode_name,
        highlight = { colors.fg, colors.bg },
        separator = " ",
        separator_highlight = { colors.bg, colors.section_bg }
    }
}, {
    FileName = {
        provider = 'FileName',
        highlight = { colors.fg, colors.section_bg },
        separator = " ",
        separator_highlight = {colors.section_bg, colors.bg},
    }
}, {
    Diagnostics = {
        provider = get_formated_line_main_diagnostic,
        highlight = { colors.red, colors.bg }
    }
}}

gls.right = {{
    DiagnosticError = {
        provider = function() return vim.lsp.diagnostic.get_count(0, 'Error') end,
        icon = icons.lsp_error,
        highlight = { colors.red, colors.bg },
        separator = " ",
        separator_highlight = { colors.section_bg, colors.bg },
    }
}, {
    DiagnosticWarn = {
        provider = function() return vim.lsp.diagnostic.get_count(0, 'Warn') end,
        icon = icons.lsp_warn,
        highlight = { colors.yellow, colors.bg},
        separator = " ",
        separator_highlight = { colors.section_bg, colors.bg },
    }
}, {
    DiagnosticInfo = {
        provider = function() return vim.lsp.diagnostic.get_count(0, 'Info') end,
        icon = icons.lsp_info,
        highlight = { colors.blue, colors.bg },
        separator = " ",
        separator_highlight = { colors.section_bg, colors.bg },
    }
}, {
    GitBranch = {
        provider = function () return vcs.get_git_branch()..' ' end,
        condition = in_git_repo,
        icon = ' '..icons.git_branch..' ',
        highlight = { colors.bg, colors.cyan },
        separator = "",
        separator_highlight = { colors.bg, colors.cyan },
    }
}, {
    LineInfo = {
        provider = 'LineColumn',
        highlight = { colors.fg, colors.section_bg },
        separator = "",
        separator_highlight = { colors.cyan, colors.section_bg },
    }
}}

