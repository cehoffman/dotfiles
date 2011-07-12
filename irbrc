require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 500
IRB.conf[:PROMPT_MODE]  = :SIMPLE

# Auto indent code
IRB.conf[:AUTO_INDENT] = true

# Readline support
IRB.conf[:USE_READLINE] = true

# DON'T USE THESE IN AN INTERACTIVE PROMPT
# They will cause line wrapping to become screwed since
# readline thinks they are physical characters you can see
# and thus doesn't know when to wrap the command
IRB::ANSI = {}
IRB::ANSI[:RESET]     = "\e[0m"
IRB::ANSI[:BOLD]      = "\e[1m"
IRB::ANSI[:UNDERLINE] = "\e[4m"
IRB::ANSI[:LGRAY]     = "\e[0;37m"
IRB::ANSI[:GRAY]      = "\e[1;30m"
IRB::ANSI[:RED]       = "\e[31m"
IRB::ANSI[:GREEN]     = "\e[32m"
IRB::ANSI[:YELLOW]    = "\e[33m"
IRB::ANSI[:BLUE]      = "\e[34m"
IRB::ANSI[:MAGENTA]   = "\e[35m"
IRB::ANSI[:CYAN]      = "\e[36m"
IRB::ANSI[:WHITE]     = "\e[37m"

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
    ActiveRecord::Base.instance_eval { alias :[] :find }
  end
end

# Nice alias to just see the methods specific to this object
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

# Loading extensions of the console. This is wrapped
# because some might not be included in your Gemfile
# and errors will be raised
def extend_console(name, care = true, required = true)
  if care
    require name if required
    yield if block_given?
    $console_extensions << "#{IRB::ANSI[:GREEN]}#{name}#{IRB::ANSI[:RESET]}"
  else
    $console_extensions << "#{IRB::ANSI[:GRAY]}#{name}#{IRB::ANSI[:RESET]}"
  end
rescue LoadError
  $console_extensions << "#{IRB::ANSI[:RED]}#{name}#{IRB::ANSI[:RESET]}"
end
$console_extensions = []

extend_console 'fancy_irb' do
  FancyIrb.start rocket_prompt: '# => ', colorize: { rocket_prompt: [:green, :bright] }
end

extend_console 'sketches' do
  Sketches.config(editor: ENV['EDITOR'], background: true, terminal: -> cmd { "tmux new-window #{cmd.dump}" })
end

extend_console 'wirb' do
  Wirb.start
  Wirb.load_schema File.expand_path('~/.irb/plasticcodewrap')
end

# Hirb makes tables easy.
extend_console 'hirb' do
  # command out the following options to get tables for everything
  Hirb.enable # :output=>{'Object'=>{:class=>:auto_table, :ancestor=>true}}
  extend Hirb::Console
end

# awesome_print is prints prettier than pretty_print
extend_console 'ap' do
  alias pp ap
end

# Add a method pm that shows every method on an object
# Pass a regex to filter these
extend_console 'pm', true, false do
  def pm(obj, *options) # Print methods
    methods = obj.methods
    methods -= Object.methods unless options.include? :more
    filter = options.select {|opt| opt.kind_of? Regexp}.first
    methods = methods.select {|name| name =~ filter} if filter

    data = methods.sort.collect do |name|
      method = obj.method(name)
      if method.arity == 0
        args = "()"
      elsif method.arity > 0
        n = method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
      elsif method.arity < 0
        n = -method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
      end
      klass = $1 if method.inspect =~ /Method: (.*?)#/
      [name.to_s, args, klass]
    end
    max_name = data.collect {|item| item[0].size}.max
    max_args = data.collect {|item| item[1].size}.max
    data.each do |item|
      print " #{IRB::ANSI[:YELLOW]}#{item[0].to_s.rjust(max_name)}#{IRB::ANSI[:RESET]}"
      print "#{IRB::ANSI[:BLUE]}#{IRB::ANSI[:BOLD]}#{item[1].ljust(max_args)}#{IRB::ANSI[:RESET]}"
      print "   #{IRB::ANSI[:GRAY]}#{item[2]}#{IRB::ANSI[:RESET]}\n"
    end
    data.size
  end
end

# Setup pbcopy through nc to allow quick posting to clipboard
extend_console 'open3' do
  def pbcopy(str)
    Open3.popen3('nc localhost 2224') { |i, o| i.print str.to_s }
  end
end

# Show results of all extension-loading
puts "#{IRB::ANSI[:GRAY]}~> Console extensions:#{IRB::ANSI[:RESET]} #{$console_extensions.join(' ')}#{IRB::ANSI[:RESET]}"
