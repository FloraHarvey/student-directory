

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

def print(students)
  count = 0
# Note that students is now being stored as an array of hashes.
# To iterate using while, need to refer to index before referencing key,
# otherwise you get a type error.
  while count <= students.count - 1
    puts "#{students[count][:name]} (#{students[count][:cohort]} cohort)"
    count += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  students = []

  name = gets.chomp

  while !name.empty? do

    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"

    name = gets.chomp
  end
  students
end

students = input_students
print_header
print(students)
print_footer(students)
