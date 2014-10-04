options.create = true
local trim
trim = function(s)
  return s:gsub("^%s*(.-)%s*$", "%1")
end
local accounts = {
  ['mail.emerson.com'] = {
    server = 'ceh.im',
    username = 'emrsn.org\\choffman',
    port = 1143,
    ssl = 'tls1.2'
  }
}
local actions = {
  ['mail.emerson.com'] = function(imap, inbox)
    local cleanup
    cleanup = function(items)
      items:contain_subject('[User Story Review]'):move_messages(imap['User Stories'])
      items:contain_subject('[Stingray stories review]'):move_messages(imap['User Stories'])
      return items:contain_subject('[Stingray Question]'):move_messages(imap['Stingray Questions'])
    end
    local review = inbox:contain_subject('[User Story Review]') + inbox:contain_subject('[Stingray Question]') + inbox:contain_subject('[Stingray stories review]')
    local actionable = review:is_unanswered():match_to('[Cc]hristopher.[Hh]offman@[Ee]merson.com')
    actionable:move_messages(imap['Need Action'])
    cleanup(imap['Need Action']:is_answered())
    cleanup(review - actionable)
    inbox:is_seen():contain_to('spmf@dmtf.org'):move_messages(imap['SPMF'])
    return inbox:is_seen():contain_from('@dmtf.org'):move_messages(imap['DMTF'])
  end
}
for account, v in pairs(accounts) do
  local username = v.username:gsub("\\", "\\\\")
  local cmd = "/usr/bin/security find-internet-password -s " .. tostring(account) .. " -a " .. tostring(username) .. " -w"
  local status, pass = pipe_from(cmd)
  if actions[account] then
    local imap = IMAP({
      server = v.server,
      username = username,
      port = v.port,
      password = trim(pass),
      ssl = v.ssl
    })
    actions[account](imap, imap.INBOX)
  end
end
