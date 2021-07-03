local orgmode = require("orgmode")

orgmode.setup({
  org_agenda_files = { '~/notes/org/**/*'},
  org_default_notes_file = '~/notes/org/main.org',
})
