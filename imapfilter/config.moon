options.create = true

trim = (s) -> s\gsub "^%s*(.-)%s*$", "%1"

accounts =
  'mail.emerson.com':
    server: 'ceh.im'
    username: 'emrsn.org\\choffman'
    port: 1143
    ssl: 'tls1.2'

actions =
  'mail.emerson.com': (imap, inbox) ->
    cleanup = (items) ->
      items\contain_subject('[User Story Review]')\move_messages imap['User Stories']
      items\contain_subject('[Stingray stories review]')\move_messages imap['User Stories']
      items\contain_subject('[Stingray Question]')\move_messages imap['Stingray Questions']

    -- Find all items that need action, e.g. User Story and Stingray Question,
    -- that are addressed to me. Copy those to an actionable mailbox.
    review = inbox\contain_subject('[User Story Review]') + inbox\contain_subject('[Stingray Question]') + inbox\contain_subject('[Stingray stories review]')
    actionable = review\is_unanswered()\match_to('[Cc]hristopher.[Hh]offman@[Ee]merson.com')

    actionable\move_messages(imap['Need Action'])

    -- Go through the actionable mailbox and move any answered ones to the
    -- archive of that type, e.g User Story or Stingray Question
    cleanup imap['Need Action']\is_answered()
    cleanup review - actionable

    -- Move all SPMF and DMTF related mail to relevant folder after having been
    -- read
    inbox\is_seen()\contain_to('spmf@dmtf.org')\move_messages imap['SPMF']
    inbox\is_seen()\contain_from('@dmtf.org')\move_messages imap['DMTF']

for account, v in pairs accounts
    username = v.username\gsub "\\", "\\\\"
    cmd = "/usr/bin/security find-internet-password -s #{account} -a #{username} -w"
    status, pass = pipe_from cmd

    if actions[account]
      imap = IMAP
        server: v.server
        username: username
        port: v.port
        password: trim pass
        ssl: v.ssl

      actions[account] imap, imap.INBOX
