local galaxyline = require('galaxyline')
local vcs = require('galaxyline.provider_vcs')
local fileinfo = require('galaxyline.provider_fileinfo')
local condition = require('galaxyline.condition')

local colors = {
    bg = '#585858',
    fg = '#eeeeee',
    section_bg = '#38393f',
    yellow = '#f1fa8c',
    cyan = '#87d7ff',
    green = '#afd787',
    orange = '#d7875f',
    magenta = '#8467a0',
    blue = '#5fafd7',
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
    local diagnostics = vim.lsp.diagnostic.get_line_diagnostics()
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
        provider = get_formated_line_main_diagnostic,
        highlight = { colors.red, colors.section_bg },
    }
}}

galaxyline.section.right = {{
     RightSeparator = {
        provider = function() return '' end,
        highlight = { colors.section_bg, colors.bg }
    }
}, {
    DiagnosticError = {
        provider = function() return vim.lsp.diagnostic.get_count(0, 'Error') end,
        icon = icons.lsp_error,
        highlight = { colors.red, colors.bg },
        separator = " ",
        separator_highlight = { colors.section_bg, colors.bg },
    }
}, {
    DiagnosticWarn = {
        provider = function() return vim.lsp.diagnostic.get_count(0, 'Warning') end,
        icon = icons.lsp_warn,
        highlight = { colors.yellow, colors.bg},
        separator = " ",
        separator_highlight = { colors.section_bg, colors.bg },
    }
}, {
    DiagnosticInfo = {
        provider = function() return vim.lsp.diagnostic.get_count(0, 'Information') end,
        icon = icons.lsp_info,
        highlight = { colors.cyan, colors.bg },
        separator = " ",
        separator_highlight = { colors.section_bg, colors.bg },
    }
}, {
    DiagnosticHint = {
        provider = function() return vim.lsp.diagnostic.get_count(0, 'Hint')..' ' end,
        icon = icons.lsp_hint,
        highlight = { colors.fg, colors.bg },
        separator = " ",
        separator_highlight = { colors.section_bg, colors.bg },
    }
}, {
    GitBranch = {
        provider = function () return vcs.get_git_branch()..' ' end,
        icon = ' '..icons.git_branch..' ',
        highlight = { colors.fg, colors.magenta },
        separator = "",
        separator_highlight = { colors.bg, colors.magenta },
        condition = condition.check_git_workspace
    }
}}
