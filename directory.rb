

def print_header
  puts "The students of Villains Academy"
  puts "----------------"
end

#def print(students)
#  students.each_with_index do |student, index|
#    if student[:name].length < 12
#    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
#    end
#  end
#end


def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  students = []

  name = gets.chomp
  hobby = ""
  nationality = ""

  while !name.empty? do

    students << {name: name, cohort: :november, hobby: hobby, nationality: nationality}
    puts "Now we have #{students.count} students"

    name = gets.chomp
  end

  puts "Please enter some further information about each student."

  students.each do |student|
    puts "What is #{student[:name]}'s favourite hobby?"
    student[:hobby] = gets.chomp
    puts "Where is #{student[:name]} from?"
    student[:nationality] = gets.chomp
  end

  students
end

def print(students)
  count = 0
# Note that students is now being stored as an array of hashes.
# To iterate using while, need to refer to index before referencing key,
# otherwise you get a type error.
  while count <= students.count - 1
    puts "#{students[count][:name]} (#{students[count][:cohort]} cohort).".center(60)
    puts "Hobby: #{students[count][:hobby]}, Nationality: #{students[count][:nationality]}".center(60)
    count += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
