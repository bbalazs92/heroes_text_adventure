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
=begin
  puts "Choose your class: Warrior or Paladin!"
  hero_class = gets.chomp
  if hero_class == "warrior"
    puts "What is your name warrior?"
    hero = Warrior.new(gets.chomp, 100, 8)        #initial hp and dmg done set here
  elsif hero_class == "paladin"
    puts "What is your name paladin?"
    hero = Paladin.new(gets.chomp, 100, 8)
  else
    puts "That is not a class!"
  end
=end
  hero = Paladin.new("Uther", 100, 8)
  return hero
end

#round based combat
def battle(hero, enemy)
  while hero.health and enemy.health > 0 do
    puts "The hero strikes!"
    hero.strike(enemy)
    puts "Enemy HP left: #{enemy.health}"
    if enemy.health <= 0                      #enemy cannot strike back if it's hp drops below 0
        puts "You defeated #{enemy.name}!"
        break
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

  enemy = Enemy.new("wolf", 20, 1)

  puts "*angry wolf noises*"
  print_ascii('wolf_ascii.txt')
  battle(hero, enemy)
  p hero.abilities
end

game