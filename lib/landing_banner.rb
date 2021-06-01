def display_ansi
    begin
    File.foreach("./banner/3-350.txt") { |line| puts line }
    rescue
        puts "Unable to find file"
    end
end