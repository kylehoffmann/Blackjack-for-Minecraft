state = 0
yes_no = 0
exit = 0
error_state = 0
answer = ""
help = 0
computer_ace = 0
player_ace = 0
computer_total = 0
player_total = 0
deck = {}
player_cards = {}
computer_cards = {}
player_next_card = 0
computer_next_card = 0


for i=1, 11 do
  player_cards[i] = 0
  computer_cards[i] = 0
end

not_implemented = 0

function clear_screen()
  i = 0
  while i < 15 do
    i = i + 1
    print("\n")
  end
  term.clear()
end

function print_card(card_num)
  if card_num > 0 then
    if card_num < 5 then
      io.write("Ace")
    elseif card_num < 9 then
      io.write("Two")
    elseif card_num < 13 then
      io.write("Three")
    elseif card_num < 17 then
      io.write("Four")
    elseif card_num < 21 then
      io.write("Five")
    elseif card_num < 25 then
      io.write("Six")
    elseif card_num < 29 then
      io.write("Seven")
    elseif card_num < 33 then
      io.write("Eight")
    elseif card_num < 37 then
      io.write("Nine")
    elseif card_num < 41 then
      io.write("Ten")
    elseif card_num < 45 then
      io.write("Jack")
    elseif card_num < 49 then
      io.write("Queen")
    else
      io.write("King")
    end
    io.write( " of " )
    temp_value = card_num - math.floor(card_num/4)*4 
    if temp_value == 1 then
      io.write("Spades   ")
    elseif temp_value == 2 then
      io.write("Clubs   ")
    elseif temp_value == 3 then
      io.write("Diamonds   ")
    else
      io.write("Hearts   ")
    end 
  end
end

function print_state( current_state )
  if current_state == 0 then
    clear_screen()
    print(" _              __      _____         _")
    print("| | |     /|   /   | /      |   /|   /  | /")
    print("|_/ |    / |  /    |/       |  / |  /   |/")
    print("| | |   |__|  \\    |\\      /  |__| |    |\\")
    print("|_/ |__ |  |   \\__ | \\  __/   |  | |___ | \\")
    print("               - Version 1.0 -")
    print("            Written By Kyle Hoffmann")
    print("\n\n         (s)tart - To Start the game!")
    print("              (h)elp - For help.")
    print("           (e)xit - To end the game.")
    if help == 1 then
      print("\n")
      print("(s)tart - To start the game")
      print("(h)elp - Prints a list of valid commands")
      print("(e)xit - Quits the program")
      print("")
    elseif error_state == 1 then
      print("\n\n\n")
      io.write(answer)
      io.write(" is not a valid command.\n")
      print("")
    else
      print("\n\n\n\n\n")
    end
  elseif current_state == 1 then
    clear_screen()
    print("Dealer: ")
    io.write("???   ")
    for i = 2, 11 do 
      print_card(computer_cards[i])
      if i == 3 or i == 6 or i == 9 then print() end
    end
    print()
    io.write("Player: " .. player_total)
    if player_total < 12 and player_ace == 1 then io.write(" \\ " .. player_total + 10) end
    print("")
    for i = 1, 11 do
      print_card(player_cards[i])
      if i == 3 or i == 6 or i == 9 then print() end
    end 
    if not_implemented == 1 then print("NOT IMPLEMENTED\n\n") end
    if help == 1 then
      print("(s)tay - To draw no cards.")
      print("(d)eal - To draw another card.")
      print("(f)old - To give up the round.")
      print("(h)elp - To print the possible commands.")
      print("(e)xit - To quit playing Black Jack.")
    elseif error_state == 1 then
      print()
      io.write(answer)
      io.write(" is not a valid command.\n")
    end
  else
    clear_screen()
    if state == 2 then print("\nYOU WIN!!!\n\n")
    else print("\nYou lost...\n\n") end 
    if computer_total < 12 and computer_ace == 1 then computer_total = computer_total + 10 end
    if player_total < 12 and player_ace == 1 then player_total = player_total + 10 end
    print(" - Final Scores -\n Computer: " .. computer_total .. "\n Player: " .. player_total .. "\n\n")
    print("Would you like to play another game? \n(y)es/(n)o?\n\n")
    if not_implemented == 1 then print("NOT IMPLEMNETED\n\n" )end
    if help == 1 then
      print("(y)es - To play another game.")
      print("(e)xit, (n)o - To quit.")
      print("(h)elp - To reprint this help message.")
    elseif error_state == 1 then
      print()
      io.write(answer)
      io.write(" is not a valid command.\n")
    end
    
  end
end

function draw_card()
  i = 0
  repeat
    check = math.random(1,52)
    if deck[check] == 0 then 
      deck[check] = 1
      i = 1
    end
  until i == 1
  return check
end

function new_round()
  for i = 1, 52 do 
    deck[i] = 0
  end
  for i = 1, 11 do 
    player_cards[i] = 0
    computer_cards[i] = 0
  end
  player_ace = 0
  computer_ace = 0
  computer_cards[1] = draw_card()
  computer_cards[2] = draw_card()
  player_cards[1] = draw_card()
  player_cards[2] = draw_card()
  player_next_card = 3
  computer_next_card = 3
end

function calculate_total()
  player_total = 0
  computer_total = 0
  for i = 1, #player_cards do
    if player_cards[i] > 40 then player_total = player_total + 10 
    else player_total = player_total + math.floor((player_cards[i]+3) / 4)
    end
    if computer_cards[i] > 40 then computer_total = computer_total + 10
    else computer_total = computer_total + math.floor((computer_cards[i]+3) / 4)
    end
    if player_cards[i] < 5 and player_cards[i] > 0 then player_ace = 1 end
    if computer_cards[i] < 5 and computer_cards[i] > 0 then computer_ace = 1 end
  end
end

function stay()
  com_temp_total = computer_total
  if com_temp_total < 12 and computer_ace == 1 then
    com_temp_total = com_temp_total + 10
  end
  pl_temp_total = player_total
  if pl_temp_total < 12 and player_ace == 1 then
    pl_temp_total = pl_temp_total + 10
  end
  
  if pl_temp_total <= com_temp_total then
    state = 3
  elseif com_temp_total < 18 then
    computer_cards[computer_next_card] = draw_card()
    computer_next_card = computer_next_card + 1
    calculate_total()
    if computer_total > 21 then
      state = 2
    end    
  else
    state = 2
  end
end

function draw()
  player_cards[player_next_card] = draw_card()
  player_next_card = player_next_card + 1
  calculate_total()
  if player_total > 21 then
    state = 3
  else
    if computer_total < 18 then
      computer_cards[computer_next_card] = draw_card()
      computer_next_card = computer_next_card + 1
      calculate_total()
      if computer_total > 21 then
        state = 2
      end
    end
  end
end

function process_answer( current_state )
  error_state = 0
  help = 0
  not_implemented = 0
  if answer == "exit" or answer == "e" then
    exit = 1
  elseif answer == "help" or answer == "h" then
    help = 1
  else
    if current_state == 0 then
      if answer == "s" or answer == "start" then
        state = 1
        new_round() 
      else
        error_state = 1
      end
    elseif current_state == 1 then
      if answer == "s" or answer == "stay" then
        stay()
      elseif answer == "d" or answer == "deal" then
        draw()
      elseif answer == "f" or answer == "fold" then
        state = 3
      else
        error_state = 1
      end
    else
      if answer == "y" or answer == "yes" then
        state = 1
        new_round()
      elseif answer == "n" or answer == "no" then
        exit = 1
      else
        error_state = 1
      end
    end
  end 
  calculate_total()
end  
      
function main()
  math.randomseed(os.time())  
  --new_round()
  repeat
    print_state(state)
    io.write(">")
    io.flush()
    answer = io.read()
    process_answer(state)
  until exit == 1
  clear_screen()
end

main()
