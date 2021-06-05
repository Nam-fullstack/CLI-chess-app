def display_ansi
  begin
  File.foreach('../banner/Banner-350.txt') { |line| puts line }
  rescue StandardError => e
    puts 'Unable to find file.'
    puts e.message
  end
end
