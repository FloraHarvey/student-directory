
@students = []

def print_header
  puts "The students of Villains Academy"
  puts "----------------"
end

def sing_or_plural(person)
  person.count > 1 ? "s" : ""
end


def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  name = gets.chomp

# Supplies default values if user input is empty
  cohort = :November
  hobby = "Being bad"
  nationality = "Unknown"

  while !name.empty? do
    @students << {name: name, cohort: cohort, hobby: hobby, nationality: nationality}
    puts "Now we have #{@students.count} student#{sing_or_plural(@students)}"

    name = gets.chomp
  end

  puts "Please enter some further information about each student."

  require "Date"

  @students.each do |student|
    puts "Which cohort is #{student[:name]} in?"
    cohort = gets.chomp.capitalize
# Checks if cohort is a valid month
      if Date::MONTHNAMES.include? cohort
        student[:cohort] = cohort.to_sym
      else puts "Please give a valid month."
        cohort = gets.chomp
      end
    puts "What is #{student[:name]}'s favourite hobby?"
      hobby = gets.chomp
      if !hobby.empty?
        student[:hobby] = hobby
      end
    puts "Where is #{student[:name]} from?"
    nationality = gets.chomp
    if !nationality.empty?
      student[:nationality] = nationality
    end
  end
end

# Prints students grouped by cohort
def print_students_list
  existing_cohorts = @students.map do |student|
    student[:cohort]
  end.uniq
  existing_cohorts.each do |cohort|
    puts "The students in the #{cohort.to_s} cohort are:"
    @students.each do |student|
      if student[:cohort] == cohort
         puts student[:name]
      end
    end
  end
end

def print_footer
  if @students.count > 0
    puts "Overall, we have #{@students.count} great student#{sing_or_plural(@students)}"
  else puts "We currently have no students."
  end
end

def print_menu
  puts "Please select one of the following options by entering a number, followed by return."
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
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
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

interactive_menu
