def rps(str)
  options = %w[Rock Paper Scissors]
  computer_choice = options.sample
  user_choice = str.capitalize

  cycle = {
    "Rock" => 0,
    "Scissors" => 1,
     "Paper" => 2
    }

  if computer_choice == "Paper" && user_choice == "Rock"
    "The computer chose #{computer_choice}, Lose"
  elsif computer_choice == "Rock" && user_choice == "Paper"
    "The computer chose #{computer_choice}, Win"
  elsif cycle[computer_choice] == cycle[user_choice]
    "The computer chose #{computer_choice}, Draw"
  elsif cycle[computer_choice] > cycle[user_choice]
    "The computer chose #{computer_choice}, Win"
  else
    "The computer chose #{computer_choice}, Lose"
  end

end

def remix(drinks)
  alcohol = []
  mixers = []

  drinks.each do |drink|
    alcohol << drink[0]
    mixers << drink[1]
  end

  alcohol.shuffle!
  mixers.shuffle!

  remixes = []
  alcohol.each_with_index do |drink, i|
    remixes << [drink, mixers[i]]
  end
  #
  # loop do
  #   repeated = false
  #   remixes.each do |remix|
  #     repeated = true if drinks.include?(remix)
  #   end
  #
  #   alcohol.shuffle!
  #   mixers.shuffle!
  #
  #   remixes = []
  #   alcohol.each_with_index do |drink, i|
  #     remixes << [drink, mixers[i]]
  #   end
  #
  #   break unless repeated
  # end

  remixes
end
