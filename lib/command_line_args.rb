# frozen_string_literal: true

if ARGV.!empty?
  flag, *rest = ARGV
  ARGV.clear
  case flag
  when '-help'
    puts 'See further documentation in readme.md'
    exit
  when '-info'
    puts "This program is using Ruby version: #{RUBY_VERSION}"
    puts 'Do you wish to open CLI Chess?'   # TTY PROMPT HERE
  when '-load'
    puts 'Please select game you wish to load'
  when '-path'
    puts ''
  else
    puts 'Invalid argument, please see readme for options'
    exit
  end

end
