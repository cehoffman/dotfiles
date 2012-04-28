# Copyright (c) 2009 Ryan Bates
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'rake'
require 'erb'

def windows?
  RUBY_PLATFORM =~ /[mswin|mingw]32/
end

def mac?
  RUBY_PLATFORM =~ /darwin/
end

desc "update the dot files into user's home directory"
task :update do
  puts 'initializing submodules'
  system 'git', 'submodule', 'update', '--init'
  system 'git', 'submodule', 'sync'
  system 'git', 'submodule', 'update', '--init', '--rebase'

  system 'git', 'clean', '-df'

  puts 'updaing opp.zsh'
  system 'zsh', '-c', 'for O in zsh/vendor/opp.zsh/{opp.zsh,opp/*.zsh}; do . $O; done && opp-zcompile ~/.zsh/vendor/opp.zsh ~/.zsh/functions'

  replace_all = windows?
  Dir['*'].each do |file|
    next if %w[Rakefile].include? file
    
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub('.erb', '')}")
        puts "identical ~/.#{file.sub('.erb', '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub('.erb', '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub('.erb', '')}"
        end
      end
    else
      link_file(file)
    end
  end

  system 'vim', '-c', ':Helptags', '-c', ':q!'
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub('.erb', '')}"}
  link_file(file)
end

if windows?
  require 'rubygems'
  require 'win32/dir'
  require 'fileutils'
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    if windows?
      if File.directory?(file)
        puts "linking ~/.#{file}"
        Dir.create_junction(File.join(ENV['HOME'], ".#{file}"), File.join(Dir.pwd, file))
      else
        puts "overwriting ~/.#{file}"
        File.unlink(File.join(ENV['HOME'], ".#{file}")) rescue nil
        FileUtils.cp(File.join(Dir.pwd, file), File.join(ENV['HOME'], ".#{file}") )
      end
    else
      puts "linking ~/.#{file}"
      File.symlink(File.join(Dir.pwd, file), File.join(ENV['HOME'], ".#{file}"))
    end
  end
end
