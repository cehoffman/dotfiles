# Load up any special local lib dirs if needed
# function {
#   typeset -xgUT RUBYLIB ruby_lib

#   # Add homebrew ruby compiles to path if they exist
#   local ruby_libs
#   local ruby_path

#   ruby_libs=${(z)$(ruby -e "require 'rbconfig' unless defined?(RbConfig); puts RbConfig::CONFIG['ruby_version'], RbConfig::CONFIG['sitearch']")}

#   for ruby_path in ~/.homebrew/lib/ruby{,/site_ruby,/vendor_ruby}; do
#     ruby_lib=($ruby_path(/) $ruby_path/$ruby_libs[1](/) $ruby_path/$ruby_libs[1]/$ruby_libs[2](/) $ruby_lib)
#   done
# }
