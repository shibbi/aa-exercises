def guess_game
  num = rand(100) + 1
  count = 0

  loop do
    puts "Guess a number: "
    guess = gets.chomp.to_i

    count += 1

    if guess == num
      puts "You've got it!!!"
      break
    elsif guess > num
      puts "Too high, guess again"
    else
      puts "Too low, guess again"
    end
  end
end

def shuffle_file
  puts "gimmie a file now!"
  file_name = gets.chomp
  lines = File.readlines(file_name)
  lines.shuffle!

  f = File.open("#{file_name}-shuffled.txt", "w")
  lines.each do |line|
    f.puts line
  end
  f.close
end

def rpn_calculator
  puts "This is an RPN calculator. The Best."
  stack = []

  get_input(stack)

  stack[0]
end

def get_input(stack)
  operands = %w(+ - * /)

  loop do
    puts "Enter a number or an operand:"
    command = gets.chomp
    if operands.include?(command)
      calculate(command, stack)
    elsif command == "exit"
      break
    else
      stack << command.to_i
    end
  end
end

def calculate(operand, stack)
  if stack.count < 2
    puts "There are no numbers in stack, dummy"
    return false
  end

  do_calculation(operand, stack)

  p stack
end

def do_calculation(operand, stack)
  number2 = stack.pop
  case operand
  when "+"
    stack << stack.pop + number2
  when "-"
    stack << stack.pop - number2
  when "*"
    stack << stack.pop * number2
  else
    stack << stack.pop / number2
  end
end
