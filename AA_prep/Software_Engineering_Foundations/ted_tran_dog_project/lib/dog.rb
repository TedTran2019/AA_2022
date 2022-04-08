class Dog
  attr_reader :name, :breed, :favorite_foods
  attr_accessor :age

  def initialize(name, breed, age, bark, favorite_foods)
    @name = name
    @breed = breed
    @age = age
    @bark = bark
    @favorite_foods = favorite_foods.map { |food| food.capitalize }
  end

  def bark
    age > 3 ? @bark.upcase : @bark.downcase
  end

  def favorite_food?(food)
    favorite_foods.include? food.capitalize
  end
end
