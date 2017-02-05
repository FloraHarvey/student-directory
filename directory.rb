
@students = []

def print_header
  puts "The students of Villains Academy"
  puts "----------------"
end

def print_footer
  if @students.count > 0
    puts "Overall, we have #{@students.count} great student#{sing_or_plural(@students)}"
  else puts "We currently have no students."
  end
end

def sing_or_plural(person)
  person.count > 1 ? "s" : ""
end

def add_student_info(name, cohort = :November)
  @students << {name: name, cohort: cohort}
end

def input_name
  name = STDIN.gets.chomp
end

def input_cohort(name)
  require "Date"
  puts "Which cohort is #{name} in?"
  cohort = STDIN.gets.chomp.capitalize
  # Checks if cohort is a valid month
  if Date::MONTHNAMES.include? cohort
    cohort = cohort.to_sym
    add_student_info(name, cohort)
  else puts "Please give a valid month."
    cohort = STDIN.gets.chomp
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = input_name
  while !name.empty? do
    input_cohort(name)
    puts "Now we have #{@students.count} student#{sing_or_plural(@students)}"
    name = input_name
  end
end

def get_cohort_list
  existing_cohorts = @students.map do |student|
    student[:cohort]
  end.uniq
end

# Prints students grouped by cohort
def print_student_list
  existing_cohorts = get_cohort_list
  existing_cohorts.each do |cohort|
    puts "The students in the #{cohort.to_s} cohort are:"
    @students.each do |student|
      if student[:cohort] == cohort
         puts student[:name]
      end
    end
  end
end



def print_menu
  puts "Please select one of the following options by entering a number, followed by return."
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list from a file"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
      puts "Saved student list to #{@filename}"
    when "4"
      get_filename
      load_students(@filename)
      puts "Loaded student list from #{@filename}"
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def get_filename
  puts "Please type the name of the file"
  @filename = STDIN.gets.chomp
end


require 'csv'

def save_students
  get_filename
  CSV.open(@filename, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      file.puts student_data
    end
  end
end

def load_students(filename = "students.csv")
  CSV.foreach(filename) do |line|
    name, cohort = line
    cohort = cohort.to_sym
    add_student_info(name, cohort)
  end
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    filename = "students.csv"
  end
  if File.exists?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} students from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

try_load_students
interactive_menu
