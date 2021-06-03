def display_ansi
  begin
    File.foreach('./banner/6-350.txt') { |line| puts line }
  rescue => e
    puts "Unable to find file."
    puts e.message
  end
end
