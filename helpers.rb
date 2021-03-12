def windows?; !!(RUBY_PLATFORM =~ /(mswin|mingw)32/) end
def mac?; !!(RUBY_PLATFORM =~ /darwin/) end
