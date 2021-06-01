
def display_ansi
    begin
    File.foreach("bg2.txt") { |line| puts line }
    rescue
        puts "Unable to find file"
    end
end

display_ansi