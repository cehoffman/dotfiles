require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 500
IRB.conf[:PROMPT_MODE]  = :SIMPLE

# Auto indent code
IRB.conf[:AUTO_INDENT] = true

# Readline support
IRB.conf[:USE_READLINE] = true

# Build a simple colorful IRB prompt
IRB.conf[:PROMPT][:SIMPLE_COLOR] = {
  :PROMPT_I => ">> ",
  :PROMPT_N => ">> ",
  :PROMPT_C => "?> ",
  :PROMPT_S => "?> ",
  :RETURN   => "#{IRB::ANSI[:GREEN]}=>#{IRB::ANSI[:RESET]} %s\n",
  :AUTO_INDENT => true }
IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR

# Just for Rails...
if defined?(Rails)
  rails_root = File.basename(Rails.root)
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I => "#{rails_root}>> ",
    :PROMPT_N => "#{rails_root}>> ",
    :PROMPT_C => "#{rails_root}?> ",
    :PROMPT_S => "#{rails_root}?> ",
    :RETURN   => "#{IRB::ANSI[:GREEN]}=>#{IRB::ANSI[:RESET]} %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :RAILS

  # Called after the irb session is initialized and Rails has
  # been loaded (props: Mike Clark).
  IRB.conf[:IRB_RC] = Proc.new do |context|
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end
end

extend_console 'wirb' do
  Wirb.start
  Wirb.load_schema File.expand_path('~/.irb/plasticcodewrap')
end
