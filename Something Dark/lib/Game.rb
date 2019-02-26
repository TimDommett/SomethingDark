require_relative "User"
require_relative "Script"

class Game
  attr_accessor :name, :scenes
  def initialize
    @inventory = []
    @scenes = {}
    @action_count = Hash.new[0]
    stage_set
    start_game
  end

  def start_game
    # intro = false   (have intro in game initialize and then intro will start_game)
    #play intro   and make intro true
    # if intro = true
    system("clear")
    slow_type("Wait... What is going on?")
    sleep(3)
    system("clear")
    slow_type("Okay, I am in my room...")
    sleep(3)
    system("clear")
    slow_type("Wait, what? Why can you hear my thoughts? Get out of my head!")
    sleep(4)
    slow_type("\n\nWho are you?\n")
    @name = gets.chomp
    player = User.new(name)
    system("clear")
    # slow_type("Okay #{name}, life is just unbareable at the moment and I dont even care that some unknown person is talking to me. I give up, what should I do?")
    # sleep(1)
    stage_set
    move(scenes[0])
    #make all text green and bigger
  end



  def display(input)
    puts input
  end


  def move(stage)
    system("clear")
    slow_type(stage.scene)
    display stage.options.values
    answer = gets.chomp
    if stage.options.keys.include?(answer.to_i) && answer.to_i == 28 #take real pills
      take_pills
      return
    elsif answer == "quit"
      puts "I'm still alive... but, okay."
    elsif stage.options.keys.include?(answer.to_i) && answer.to_i == 26 #write note
      write_parents_note
    elsif stage.options.keys.include?(answer.to_i) && answer.to_i == 12 #write note
      cut_wrists
      write_parents_note
    elsif answer.to_i == 666
      system("clear")
      slow_type("Hay.. theres been a window in this room the whole time. Oh well..")
      sleep(3)
      system("clear")
      slow_type("\n\nShe runs towards the window and leaps out")
      sleep(2)
      system("clear")
      slow_type("\n\nWith her last thought she thinks:")
      sleep(2)
      system("clear")
      puts "\n\nFinally! Here I come nothingness!"
      sleep(7)
    elsif answer == "ghost"
      system("clear")
      slow_type("Oooooh, I can walk through walls...\n\n")
      ghosts = []
      scenes.each_value { |scene| ghosts << scene.options.values }
      ghosts.uniq.each { |chr| puts chr }
      slow_type("\n\nWhere should we go #{name}?\n\n")
      thing = gets.chomp.to_i
      move(scenes[thing])
    elsif stage.options.keys.include?(answer.to_i)
      move(scenes[answer.to_i])
    else
      puts "I can't do that #{name}"
      sleep(2)
      second_move(stage)
    end
  end


  # def scenes[]=(input, second)
  #   @scenes[input] = second
  # end



  def stage_set #the name might be a fuck up
    #the hash for options is actualy unneccisary (fix this later)
    #set all extra stuff as new parts of the nested hash. eg what options they can choose from each place (have a helper method that checks this)
    #and another helper method that uses the next part of the hash for extra functions for a scene
    scene = "Okay #{name}, life is just unbareable at the moment and I dont even care that some unknown person is talking to me in my mind. I give up, what should I do?\n\n"
    options = {
      1 => "1. Goto Bathroom",
      2 => "2. Do nothing, wait it out and die the natural way",
      3 => "3. Try smother myself with a pillow",
      6 => "6. Call out for satans help",
      9 => "9. Go down stairs"

    }
      # 4. Look
      # 5. Walk to kitchen
      # 6. Call out for satans help}
    scenes[0] = Script.new(scene, options)

    #1. bathroom - code ways to go back(Walk back to room etc)
    scene = "Okay #{name}, lets see whats in the bathroom.\n\n"
    options = {
      0 => "0. Go back to Bedroom",
      4 => "4. Wash Face",    #"that was boring"
      5 => "5. Scream into mirror and see if face will change",
      7 => "7. look for scizzors",
      #downs the pills then realizes they were vitamins(or something funnier)
      #pick up pill bottle - (temp have him try kill himself) put pills in pocket, read label, down the hatch
    }
    scenes[1] = Script.new(scene, options)

    #2. do nothing
    scene = "Okay... \n\n\n\nGod, I am so bored. This is taking too long.\n\n"
    options = {
      1 => "1. Goto Bathroom",
      2 => "2. Do nothing, wait it out and die the natural way",
      3 => "3. Try smother yourself with a pillow",
      6 => "6. Call out for satans help",
      9 => "9. Go down stairs"
    }
    scenes[2] = Script.new(scene, options)

    #3. smother with pillow
    scene = "If only there was someone to do this for me…\n\n"
    options = {
      1 => "1. Goto Bathroom",
      2 => "2. Do nothing, wait it out and die the natural way",
      3 => "3. Try smother yourself with a pillow",
      6 => "6. Call out for satans help",
      9 => "9. Go down stairs"
    }
    scenes[3] = Script.new(scene, options)

    #1. bathroom - code ways to go back(Walk back to room etc)
    scene = "Well that was boring\n\n"
    options = {
      0 => "0. Go back to Bedroom",
      4 => "4. Wash Face",
      5 => "5. Scream into mirror and see if your face will change",
      7 => "7. look for scizzors",
    }
    scenes[4] = Script.new(scene, options)



    #5.scream in bathroom
    scene = "AAAAAAAAAH!!!!!!!!!!!!!!!! \n\nNope I still hate my face.\n\n"
    options = {
      0 => "0. Go back to Bedroom",
      4 => "4. Wash Face",
      7 => "7. look for scizzors",
    }
    scenes[5] = Script.new(scene, options)

    # "6. Call out for satans help"
    scene = "Satan! Come save me from this retched existence! \n\nSatan? \n\nSatan...\n\nOh yeah, since God doesn't exist neither does the devil.\n\n"
    options = {
      1 => "1. Goto Bathroom",
      2 => "2. Do nothing and try to ride it out",
      3 => "3. Try smother yourself with a pillow",
      6 => "6. Call out for satans help",
      9 => "9. Go down stairs"
    }
    scenes[6] = Script.new(scene, options)

    #7.look for scizors
    scene = "Found them...\n\n"
    options = {
      11 => "11. Sideways for attention",    #"that was boring"
      12 => "12. Long ways for results",
    }
    scenes[7] = Script.new(scene, options)

    # 11 - sideways for attention
    scene = "Ow...That just hurt.\n\nWell that was stupid.\n\n"
    options = {
      4 => "4. Wash Face",    #"that was boring"
      5 => "5. Scream into mirror and see if face will change",
      7 => "7. look for scizzors",
    }
    scenes[11] = Script.new(scene, options)

    # # 12 - long ways for results
    # scene = "She passed out...\n\n\nAll I can hear is the sound of an abulance\n\n\nFinally... Maybe I won't wake up this time.\n\n\n\n\n\n\n\n\nShe wakes up in a her bed with bandages on her arm.\n\n\nFuck!\n\n"
    # options = {
    #   1 => "1. Goto Bathroom",
    #   2 => "2. Do nothing, wait it out and die the natural way",
    #   3 => "3. Try smother yourself with a pillow",
    #   6 => "6. Call out for satans help"
    # }
    # scenes[12] = Script.new(scene, options)

    #666
    scene = "Hay.. theres been a window in this room the whole time. Oh well..\n\nShe runs towards the window and leaps out"
    options = {
      1 => "She runs towards the window and leaps out",
      2 => "With her last thought she thinks:",
      3 => "Finally! Here I come nothingness!"
    }
    scenes[666] = Script.new(scene, options)


    #downstairs
    scene = "Okay, where should we go #{name}?\n\n"
    options = {
      0 => "0. Go back to room",
      13 => "13. Go outside",
      14 => "14. Go to kitchen",
      15 => "15. Go to parents bedroom"
    }
    scenes[9] = Script.new(scene, options)

    #Outside
    scene = "Oh no! The crippling anxiety! \n\nIm going back inside\n\n"
    options = {
      13 => "13. Please, Don't make me go outside again #{name}",
      14 => "14. Go to kitchen",
      15 => "15. Goto parents bedroom"
    }
    scenes[13] = Script.new(scene, options)

    #kitchen
    scene = "What now?\n\n"
    options = {
      9 => "9. Go back",
      16 => "16. Use the knife",
      17 => "17. Go to fridge",
      18 => "18. Watch tv on the couch"
    }
    scenes[14] = Script.new(scene, options)

    #knife
    scene = "Thats way too gruesome #{name}. I'm too sober for this.\n\n"
    options = {
      9 => "9. Go back",
      17 => "17. Go to fridge",
      18 => "18. Watch tv on the couch"
    }
    scenes[16] = Script.new(scene, options)

    #fridge
    scene = "Theres hardly anything in here. Even my fridge is depressing\n\n"
    options = {
      9 => "9. Go back",
      19 => "19. Drink the bottle of whiskey",
      20 => "20. Make pancakes"
    }
    scenes[17] = Script.new(scene, options)

    #Pancakes
    scene = "It did nothing to fill the emptyness in my soul\n\n"
    options = {
      9 => "9. Go back",
      19 => "19. Drink the bottle of whiskey",
    }
    scenes[20] = Script.new(scene, options)

    #whiskey
    scene = "That actually made this a little bit easier to deal with, thanks #{name}\n\n\n2 hour later...\n\nOkay, well now everything is the same and I have a headache. Thanks a lot #{name}\n\n"
    options = {
      9 => "9. Go back",
      20 => "20. Make pancakes"
    }
    scenes[19] = Script.new(scene, options)

    #Watch TV
    scene = "What should we watch\n\n"
    options = {
      31 => "31. Watch News Bloopers",
      32 => "32. Watch a Movie"
    }
    scenes[18] = Script.new(scene, options)

    #News Bloopers
    scene = "Female presenter: So tell me sir how did you loose your backpack?\n\nYoung man with red eyes: It fell off the bridge right here.. all my coke was in there man. \n\nFemale presenter: Wait what was in your bag? \n\nYoung man with red eyes: Yeah man, there was 3 kilograms of cocaine. It's right down there in the water\n\nFemale presenter leans over the rails of the bridge. \nFemale presenter: Woah, woah!\nFemale presenter falls off of bridge into the tems river. \n\nHa, Atleast some things are still funny\n\n"
    options = {
      9 => "9. Go back",
      20 => "20. Make pancakes",
      18 => "18. Carry on watching tv like a slob"
    }
    scenes[31] = Script.new(scene, options)

    #Movie
    scene = "Why is nothing interesting anymore? Every movie is either a remake or a sequal. \n\nFuck, the world sucks.\n\n"
    options = {
      9 => "9. Go back",
      20 => "20. Make pancakes",
      18 => "18. Carry on watching tv like a slob"
    }
    scenes[32] = Script.new(scene, options)

    #parents bedroom 15
    scene = "Weird, I don't even remember the last time I was in here\n\n"
    options = {
      9 => "9. Go back",
      23 => "23. Goto parents Bathroom",
      24 => "24. Steal money from moms purse ",
      26 => "26. Write your parents a note "
    }
    scenes[15] = Script.new(scene, options)

    #parents bathroom
    scene = "Let's see what we can find in here\n\n"
    options = {
      15 => "15. Go back to bedroom",
      27 => "27. Cry on the shower floor",
      28 => "28. Bottle of pills",
    }
    scenes[23] = Script.new(scene, options)

    #steal money
    scene = "Well now I just feel like an ass hole, thanks #{name} \n\n"
    options = {
      9 => "9. Go back",
      23 => "23. Goto parents Bathroom",
      # 25 => "25. Do something fucked up - Youre just an asshole #{name}",
      26 => "26. Write your parents a note "
    }
    scenes[24] = Script.new(scene, options)

    #cry on shower floor
    scene = "Just give me a minute #{name}...\n\nThis is actually quite peaceful...\n\n"
    options = {
      15 => "15. Go back to bedroom",
      28 => "28. Bottle of pills",
    }
    scenes[27] = Script.new(scene, options)

    #parents bedroom 300 - after write note
    scene = "Hmm... What else is in here?\n\n"
    options = {
      9 => "9. Go back",
      23 => "23. Goto parents Bathroom",
      24 => "24. Steal money from moms purse ",
    }
    scenes[300] = Script.new(scene, options)

    #own room - Depressed 300
    scene = "You're going to be alright #{name}...\n\nBut #{name}, I still can't do this anymore. Please help me.\n\n"
    options = {
      1 => "1. Goto Bathroom",
      2 => "2. Do nothing, wait it out and die the natural way",
      3 => "3. Try smother myself with a pillow",
      6 => "6. Call out for satans help",
      9 => "9. Go down stairs"
    }
    scenes[400] = Script.new(scene, options)

    #cut wrists
    scene = "Well that didn't work... What now #{name}?\n\n"
    options = {
      1 => "1. Goto Bathroom",
      2 => "2. Do nothing, wait it out and die the natural way",
      3 => "3. Try smother myself with a pillow",
      6 => "6. Call out for satans help",
      9 => "9. Go down stairs",
    }
    scenes[500] = Script.new(scene, options)

  end

  def take_pills
    system("clear")
    slow_type("Huh.. this doesnt have a label on it. Should I try them, #{name}?\n\n")
    puts "1. Take them\n"
    puts "2. Put the bottle down\n"
    answer = gets.chomp.to_i
    if answer == 1
      system("clear")
      slow_type("Woah...")
      sleep(2)
      slow_type("\n\nThe walls are breathing...")
      sleep(2)
      slow_type("\n\nThe colors are so vibrant and there are beautifully intricate fractal patterns all around me...")
      sleep(2)
      slow_type("\n\nI don't know what these are, but I feel great")
      sleep(2)
      system("clear")
      slow_type("I think I trust you now #{name}\n\n")
      slow_type("Let's stumble to the kitchen, I'm hungry\n\n")
      sleep(3)
      system("clear")
      slow_type("Hmm... The booze or food?\n\n")
      puts "1. Order a pizza\n"
      puts "2. Down the bottle of whiskey\n"
      answer = gets.chomp.to_i
      sleep(1)
      system("clear")
        if answer == 1
          slow_type("Congrats #{name}, you're just depressed, not suicidal. Lets eat our troubles away, cry ourselves to sleep and try another day tomorrow.")
          slow_type("\n\nGoodnight #{name}...")
          sleep(5)
          move(scenes[400])
        elsif answer == 2
          slow_type("Here we go...")
          sleep(2)
          slow_type("\n\nOne last thing, lets write down our last words so they know it wasn't a mistake")
          slow_type("\n\n#{name}... what would you write?")
          sleep(1)
          slow_type("\n\nSeriously I want to know\n")
          answer_2 = gets.chomp
          system("clear")
          slow_type(answer_2)
          sleep(2)
          slow_type("\n\nThats perfect.")
          sleep(4)
          system("clear")
          slow_type("#{name}...")
          sleep(2)
          slow_type("\n\n\nDo you think when I die that you will disapear too?")
          sleep(2)
          slow_type("\n\nI hope not, I like you #{name}")
          sleep(4)
          system("clear")
          slow_type("I think this is it.")
          sleep(3)
          system("clear")
          slow_type("No one has ever undertood that this is what I wanted until you helped me. \n\nThank you #{name}...")
          sleep(10)
          slow_type("\n\n\n\n\nGoodbye #{name}")
          sleep(3)
          return
        end

        # write your own last words it will print them back to you and say a tear drops down and smudges them
        #she thanks you by name and then slowly falls asleep on the couch and with a final release ceases to exist.
        #(possibly chnage like the background or somehthing when begin to haluciante and something at ending


        elsif answer == 2
          system("clear")
          puts "Okay"
          move(scenes[23])
        else
          take_pills
      end
    end
  # end

  def write_parents_note
    sleep(2)
    system("clear")
    slow_type ("What would you tell your parents #{name}?  \n\nIm serious, tell me. What would you write?\n\n")
    answer = gets.chomp
    system("clear")
    slow_type("Okay, lets see...\n\n")
    slow_type(answer)
    slow_type("\n\nI think they would have appreciated that #{name}")
    sleep(4)
    system("clear")
    slow_type("Okay, hopefully they'll understand now. Lets figure this out.")
    sleep(2)
    move(scenes[300])
  end

  def cut_wrists
    system("clear")
    slow_type("She passed out...")
    sleep(2)
    slow_type("\n\n\n All I can hear is the sound of an abulance")
    sleep(2)
    slow_type("\n\n\nFinally... Maybe I won't wake up this time...")
    sleep(5)
    system("clear")
    slow_type("She wakes up in a her bed with bandages on her arm.")
    sleep(1)
    slow_type("\n\n\nFuck!")
    sleep(4)
    move(scenes[500])
  end

  def intro

  end

  def slow_type(text)
    text.each_char do |char|
     putc char
     $stdout.flush
     sleep 0.05
    end
  end

  def second_move(stage)
    system("clear")
    display(stage.scene)
    display stage.options.values
    answer = gets.chomp
    if stage.options.keys.include?(answer.to_i) && answer.to_i == 28 #take real pills
      take_pills
      return
    elsif stage.options.keys.include?(answer.to_i) && answer.to_i == 12 #write note
      cut_wrists
    elsif stage.options.keys.include?(answer.to_i) && answer.to_i == 26 #write note
      write_parents_note
    elsif answer.to_i == 666 #kills character from any point in the Game
      system("clear")
      slow_type("Hay.. theres been a window in this room the whole time. Oh well..")
      sleep(3)
      system("clear")
      slow_type("\n\nShe runs towards the window and leaps out")
      sleep(2)
      system("clear")
      slow_type("\n\nWith her last thought she thinks:")
      sleep(2)
      system("clear")
      slow_type("\n\nFinally! Here I come nothingness!")
      sleep(7)
    elsif answer == "ghost" #opens up all options
      system("clear")
      slow_type("Oooooh, I can walk through walls...\n\n")
      ghosts = []
      scenes.each_value { |scene| ghosts << scene.options.values }
      ghosts.uniq.each { |chr| puts chr }
      slow_type("\n\nWhere should we go #{name}?\n\n")
      ghst = gets.chomp.to_i
      move(scenes[ghst])
    elsif stage.options.keys.include?(answer.to_i)
      move(scenes[answer.to_i])
    else
      puts "I can't do that #{name}"
      sleep(2)
      second_move(stage)
    end
  end


end
