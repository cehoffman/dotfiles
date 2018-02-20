# DON'T USE THESE IN AN INTERACTIVE PROMPT
# They will cause line wrapping to become screwed since
# readline thinks they are physical characters you can see
# and thus doesn't know when to wrap the command
TERM_COLORS = {}
TERM_COLORS[:RESET]     = "\e[0m"
TERM_COLORS[:BOLD]      = "\e[1m"
TERM_COLORS[:UNDERLINE] = "\e[4m"
TERM_COLORS[:LGRAY]     = "\e[0;37m"
TERM_COLORS[:GRAY]      = "\e[1;30m"
TERM_COLORS[:RED]       = "\e[31m"
TERM_COLORS[:GREEN]     = "\e[32m"
TERM_COLORS[:YELLOW]    = "\e[33m"
TERM_COLORS[:BLUE]      = "\e[34m"
TERM_COLORS[:MAGENTA]   = "\e[35m"
TERM_COLORS[:CYAN]      = "\e[36m"
TERM_COLORS[:WHITE]     = "\e[37m"

# Loading extensions of the console. This is wrapped
# because some might not be included in your Gemfile
# and errors will be raised
def extend_console(name, use_require: true)
  require name if use_require
  yield if block_given?
  $console_extensions << "#{TERM_COLORS[:GREEN]}#{name}#{TERM_COLORS[:RESET]}"
rescue LoadError
  $console_extensions << "#{TERM_COLORS[:RED]}#{name}#{TERM_COLORS[:RESET]}"
end
$console_extensions = []

# Nice alias to just see the methods specific to this object
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

require_relative "irb/irb" if defined?(IRB)

extend_console 'wirb' do
  Wirb.start
  Wirb.load_schema File.expand_path('~/.dotfiles/irb/plasticcodewrap')
end

extend_console 'fancy_irb' do
  FancyIrb.start rocket_prompt: '# => ', colorize: { rocket_prompt: [:green, :bright] }
end

extend_console 'sketches' do
  Sketches.config(editor: ENV['EDITOR'], background: true, terminal: -> cmd { "tmux new-window #{cmd.dump}" })
end

# Hirb makes tables easy.
extend_console 'hirb' do
  # command out the following options to get tables for everything
  Hirb.enable # :output=>{'Object'=>{:class=>:auto_table, :ancestor=>true}}
  extend Hirb::Console
end

# awesome_print is prints prettier than pretty_print
extend_console 'awesome_print' do
  alias pp ap
end

# Add a method pm that shows every method on an object
# Pass a regex to filter these
extend_console 'pm', use_require: false do
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
      print " #{TERM_COLORS[:YELLOW]}#{item[0].to_s.rjust(max_name)}#{TERM_COLORS[:RESET]}"
      print "#{TERM_COLORS[:BLUE]}#{TERM_COLORS[:BOLD]}#{item[1].ljust(max_args)}#{TERM_COLORS[:RESET]}"
      print "   #{TERM_COLORS[:GRAY]}#{item[2]}#{TERM_COLORS[:RESET]}\n"
    end
    data.size
  end
end

extend_console 'cp', use_require: false do
  # Setup pbcopy through nc to allow quick posting to clipboard
  require 'socket'
  def pbcopy(str)
    TCPSocket.open('localhost', 2224) do |io|
      io.set_encoding Encoding::UTF_8
      io.send str.to_s, 0
    end
  end

  def pbpaste
    TCPSocket.open('localhost', 2225) do |io|
      io.set_encoding Encoding::UTF_8
      io.read
    end
  end
end

extend_console 'tmux', use_require: false do
  # Setup ability to copy the tmux buffer
  def tcopy(str)
    system 'tmux', 'set-buffer', str.to_s if ENV['TMUX']
  end

  def tpaste
    IO.popen(['tmux', 'show-buffer']) { |io| io.read.chomp } if ENV['TMUX']
  end
end

# Show results of all extension-loading
puts "#{TERM_COLORS[:GRAY]}~> Console extensions:#{TERM_COLORS[:RESET]} #{$console_extensions.join(' ')}#{TERM_COLORS[:RESET]}"
