local galaxyline = require('galaxyline')
local fileinfo = require('galaxyline.provider_fileinfo')
local condition = require('galaxyline.condition')

vim.o.laststatus = 3

local colors = {
    bg = '#585858',
    fg = '#EFF6FA',
    section_bg = '#38393f',
    yellow = '#F4BC47',
    cyan = '#55C3B7',
    green = '#8CAE5B',
    orange = '#d7875f',
    magenta = '#8467a0',
    blue = '#55C3B7',
    red = '#d75f5f'
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

local function mode_color(severity)
    if (severity == 1) then return colors.red end
    if (severity == 2) then return colors.yellow end
    if (severity == 3) then return colors.cyan end
    if (severity == 4) then return colors.fg end
    return colors.fg
end

local function get_line_main_diagnostic()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local diagnostics = vim.diagnostic.get(0, { lnum = cursor.row })
    if (#diagnostics == 0) then return nil end
    return diagnostics[1]
end

local function get_formated_line_main_diagnostic()
    local diagnostic = get_line_main_diagnostic()
    if (diagnostic == nil) then return nil end

    vim.api.nvim_command('hi GalaxyDiagnostics guifg='..mode_color(diagnostic.severity))
    local main_icon = diagnostics_icons[diagnostic.severity]

    return ' '..main_icon..' '..diagnostic.message
end

galaxyline.section.left = {{
    LeftSeparator = {
        provider = function() return '▋' end,
        highlight = { colors.blue, colors.bg }
    },
}, {
    FileIcon = {
        provider = fileinfo.get_file_icon,
        highlight = { fileinfo.get_file_icon_color, colors.bg },
        condition = condition.buffer_not_empty
    }
}, {
    FileName = {
        provider = function() return fileinfo.get_current_file_path(nil, icons.lock) end,
        highlight = { colors.fg, colors.bg },
        separator = "",
        separator_highlight = { colors.bg, colors.section_bg },
        condition = condition.buffer_not_empty
    }
}, {
    Diagnostics = {
        provider = function() end, --get_formated_line_main_diagnostic,
        highlight = { colors.red, colors.section_bg },
    }
}}

galaxyline.section.right = {{
    WorkspaceError = {
        provider = function() return #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR }) end,
        icon = icons.lsp_error,
        highlight = { colors.red, colors.section_bg },
        separator = " ",
        separator_highlight = { colors.bg, colors.section_bg },
    }
}, {
    WorkspaceWarn = {
        provider = function() return #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.WARN }) end,
        icon = icons.lsp_error,
        highlight = { colors.yellow, colors.section_bg },
        separator = " ",
        separator_highlight = { colors.bg, colors.section_bg },
    }
}, {
     RightSeparator = {
        provider = function() return '' end,
        highlight = { colors.section_bg, colors.bg },
        separator = " ",
        separator_highlight = { colors.bg, colors.section_bg }
    }
}, {
    DiagnosticError = {
        provider = function() return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }) end,
        icon = icons.lsp_error,
        highlight = { colors.red, colors.bg},
        separator = " ",
        separator_highlight = { colors.section_bg, colors.bg },
    }
}, {
    DiagnosticWarn = {
        provider = function() return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }) end,
        icon = icons.lsp_warn,
        highlight = { colors.yellow, colors.bg},
        separator = " ",
        separator_highlight = { colors.section_bg, colors.bg },
    }
}, {
    DiagnosticInfo = {
        provider = function() return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }) end,
        icon = icons.lsp_info,
        highlight = { colors.cyan, colors.bg },
        separator = " ",
        separator_highlight = { colors.section_bg, colors.bg },
    }
}, {
    DiagnosticHint = {
        provider = function() return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }) end,
        icon = icons.lsp_hint,
        highlight = { colors.fg, colors.bg },
        separator = " ",
        separator_highlight = { colors.section_bg, colors.bg },
    }
}, {
     FinalSeparator = {
        provider = function() return ' ' end,
        highlight = { colors.section_bg, colors.bg }
    }
}}

