def print_source_code
  # open file with source code ($0)
  File.open($0, "r") do |file|
    # read each line and print to screen
    file.readlines.each do |line|
      puts line
    end
  end
end

print_source_code
