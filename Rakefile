# Copyright (c) 2009-2013 Chris Hoffman
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
require 'fileutils'

def windows?; RUBY_PLATFORM =~ /(mswin|mingw)32/ end
def mac?; RUBY_PLATFORM =~ /darwin/ end

if ENV['DEBUG']
  def system(*args)
    puts args.join(' ')
    super
    puts $?
  end
end

task :default => :update

desc 'update git submodules'
task :submodule do
  puts 'initializing submodules'
  system 'git', 'submodule', 'update', '--init', '--recursive'
  system 'git', 'submodule', 'sync'
  system 'git', 'submodule', 'update', '--init', '--recursive', '--rebase'
end

namespace :submodule do
  desc 'get the latest versions of submodules from upstream'
  task :upstream do
    system 'git', 'submodule', 'foreach', 'git', 'checkout', 'master'
    system 'git', 'submodule', 'foreach', 'git', 'pull', '--rebase'
  end
end

$replace_all_files = false

desc 'link a specified file/folder to your home directory'
task :link, :name do |_, args|
  return unless File.exists?(args[:name])
  home_file = File.join(ENV['HOME'], ".#{args[:name].sub(/\.erb$/, '')}")

  erb  = args[:name] =~ /\.erb$/ && ERB.new(File.read(args[:name])).result(binding)

  if File.exists?(home_file)
    if File.identical?(home_file, args[:name])
      puts "identical, skipping #{args[:name]}"
    elsif $replace_all_files
      FileUtils.rm_rf home_file
      Rake::Task['link'].invoke(args[:name])
    else
      if erb && File.read(home_file) == erb
        puts "identical, skipping #{args[:name].sub(/\.erb$/, '')}"
      else
        puts "overwrite ~/.#{args[:name]} [ynaq]"
        case $stdin.gets.chomp
        when 'y'
          FileUtils.rm_rf(home_file)
          Rake::Task['link'].reenable
          Rake::Task['link'].invoke(args[:name])
        when 'a'
          $replace_all_files = true
          Rake::Task['link'].reenable
          Rake::Task['link'].invoke(args[:name])
        when 'q' then exit
        else puts "skipping #{args[:name]}" end
      end
    end
  else
    if args[:name] =~ /\.erb$/
      puts "generating #{home_file}"
      File.open(home_file, 'w') { |new_file| new_file.write erb }
    else
      target = File.basename(Dir.pwd) + (File::ALT_SEPARATOR || File::SEPARATOR) + args[:name]
      link = File.basename(home_file)

      Dir.chdir ENV['HOME'] do
        puts "linking ~/#{link}"

        if windows?
          switch = File.directory?(target) && ['/d'] || []
          switch << [link, target]
          system 'cmd', '/c', 'mklink', *switch.flatten
          system 'cmd', '/c', 'attrib', link, '+s', '+h'
        else
          File.symlink(target, link)
        end
      end
    end
  end
end

desc "update the dot files into user's home directory"
task :update, :speed do |_, args|
  Rake::Task['submodule'].invoke unless args[:speed] == 'fast'

  system 'git', 'clean', '-df'

  Dir['*'].each do |file|
    next if %w[Rakefile os].include? file
    Rake::Task['link'].invoke(file)
    Rake::Task['link'].reenable
  end

  case RUBY_PLATFORM
  when 'darwin' then Dir.chdir('os/mac') { system 'rake', 'install' }
  end

  vim = %x[zsh -c 'echo =$aliases[vim]'].chomp
  vim = vim == '=' && 'vim' || vim
  system vim, '+BundleInstall', '+BundleClean!', '+qa'
  system vim, '+BundleUpdate', '+qa' unless args[:speed] == 'fast'
end
