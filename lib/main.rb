#$LOAD_PATH << '.'          This makes ruby aware that included files must be searched in the current directory. I still prefer the require_relative command because it improves code readability.
require_relative 'skills'

class Warlord
  include Skills

  attr_reader :name, :power
  attr_accessor :health, :abilities

  def initialize(name, health, power, abilities=["strike"])
    @name = name
    @health = health
    @power = power
    @abilities = abilities
  end

  def introduction
    puts "I am #{@name}, a new challenger!"
  end

end

class Warrior < Warlord

end

class Paladin < Warlord

end

class Enemy < Warlord

end

#method to print out ascii art
def print_ascii(filename)
  File.open("../ascii_art/#{filename}").readlines.each do |line|
    puts line
  end
end

#hero creation
def create_hero
  puts "Choose your class: Warrior or Paladin!"
  hero_class = gets.chomp
  if hero_class == "warrior"
    puts "What is your name warrior?"
    hero = Warrior.new(gets.chomp, 100, 8)        #initial hp and dmg done set here
  elsif hero_class == "paladin"
    puts "What is your name paladin?"
    hero = Paladin.new(gets.chomp, 100, 8, ["strike", "heal"])
  else
    puts "That is not a class!"
  end
  return hero
end

#round based combat
def battle(hero, enemy)
  round_counter = 0
  while hero.health and enemy.health > 0 do
    round_counter += 1
    puts "Round: #{round_counter}"
    puts "What is your next action? Your abilities: " + "#{hero.abilities}."
    user_input = gets.chomp
    while !hero.abilities.include?(user_input)
      puts "That is not a valid input."
      user_input = gets.chomp
    end
    puts "The hero uses #{user_input}!"
    if user_input == "strike"
      hero.strike(enemy)
      puts "Enemy HP left: #{enemy.health}"
      if enemy.health <= 0                      #enemy cannot strike back if it's hp drops below 0
          puts "You defeated #{enemy.name}!"
          break
      end
    elsif user_input == "heal"
      hero.heal
      puts "Hero HP left: #{hero.health}"
    end
    puts "The enemy retaliates!"
    enemy.strike(hero)
    puts "Hero HP left: #{hero.health}"
 end
end

#the main method of the game, storytelling and battles happen here
def game
  puts "Heroes: A Text Based Adventure"
#create a hero
  hero = create_hero
  hero.introduction
#game starts
  puts "#{hero.name}, as you wander into the forest, you encounter a hungry wolf. Although malnourished,
  the wolf strikes immediately as it notices you. Prepare for battle!"

  enemy = Enemy.new("wolf", 10, 4)

  puts "*angry wolf noises*"
  print_ascii('wolf_ascii.txt')
  battle(hero, enemy)
end

game
#create a map and add travel commands
#add an inventory