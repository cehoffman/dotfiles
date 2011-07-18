require 'rubygems'
require 'irb/ext/history'

extend_console 'wirb' do
  require 'paint'
  require 'irb/ext/colorize'

  module IRB
    class WirbFormatter < ColoredFormatter
      def color(type)
        type = ColoredFormatter::TYPE_ALIASES.fetch(type, type)
        Wirb.schema[type]
      end

      def colorize_token(type, token)
        if color = color(type)
          Paint[token, *color]
        else
          token
        end
      end

      def result(object)
        "#{Formatter::RESULT_PREFIX} #{colorize(inspect_object(object))}"
      end
    end
  end

  Wirb.load_schema File.expand_path('~/.irb/plasticcodewrap')
  IRB.formatter = IRB::WirbFormatter.new
end

IRB.formatter.prompt = :simple
