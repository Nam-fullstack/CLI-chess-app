def display_ansi
  File.foreach('./banner/5-350.txt') { |line| puts line }
rescue IOError => e
  puts 'Unable to find file.'
  puts e.message
end
