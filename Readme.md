# About

These are my dotfiles. There are many like them, but these are mine.

My dotfiles are my best friend. They are my life. I must master them as I must
master my life.

My dotfiles, without me, are useless. Without my dotfiles I am useless.

# Preferences & Programs

I use [VIM](http://www.VIM.org) and pretty much everything throughout my line
editing interfaces reflect this. It is a great work in progress as emacs seems
to have permeated all line editing libs, but whenever I find a VIM mapping that
doesn't work the way I want I make an effort to change the config so it does.

I use [rbenv](https://github.com/sstephenson/rbenv) because it is simple,
hackable, and generally does not get in the way.

I use mutt with gpgme to read email. I use
[msmtp](http://msmtp.sourceforge.net) to send email. I use
[offlineimap](http://offlineimap.org) to sync all my mail accounts (thankfully
all imap) onto my local computer for mutt to interact with. I'm experimenting
with [notmuch](http://notmuchmail.org) for tagging and writing a replacement
for mutt in VIM with ruby.

I develop with ruby extensively. Hence I have my things tailored for ruby and
many utility programs I make are done with ruby. I only drop to zsh if I feel
the startup is too much given the simplicity of the program.

I am extremely sensitive to delays and quirks in my interfaces. If they exist
I tend to no longer use those tools.

I have evolved my own color scheme from a TextMate scheme I found long ago on
some list. In general I don't think it resembles that too much. I do try and
make it appear in any terminal interfaces I use but many terminal interfaces
suck at good color handling. VIM does not, and hence I usually find a VIM
based way of doing the task (hence the notmuch interface in VIM). The
color scheme is called `plasticcodewrap`.

Because of my efforts to make everything work together, I usually make
modifications to homebrew packages. If I have a dotfile in here I most likely
have a tweaked formula in my personal [homebrew
clone](https://github.com/cehoffman/homebrew). 

I've written a very basic workalike to homebrew for Linux systems as a single
gem install called [coresys](https://github.com/cehoffman/coresys). It is
targeted at Linux and is currently in trial development mode. I use it for my
virtual machines, but I'm also actively hacking on it.

I have a fork of [iTerm2](http://github.com/cehoffman/iTerm2) that replaces the
font size estimation engine with one that matches to the best of my perception
the font estimation engine in [MacVim](http://macvim.org). I did this so my
custom font with special glyphs for my VIM statusline works the same in the
terminal or in the GUI.

# Using

There is a basic rake task called `update` which will take care of initializing
all the submodules, compiling all needed pieces, and then linking all top level
files and folders in your home directory. The linking code is currently taken
from Ryan Bates dotfiles.

Once you are setup, updating the dotfiles is a simple call to the shell
function `update` which will take care of saving any temporary work on tracked
files, updating the code base, putting back code changes, and then delegating
to rake task to update all submodules and plugins.

What my [iTerm2](http://github.com/cehoffman/iTerm2) session looks like.

![iTerm2 in action](https://github.com/downloads/cehoffman/dotfiles/terminal.png)
