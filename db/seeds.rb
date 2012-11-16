# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def random_user
  count = User.count
  rand = Random.new.rand(0..count-1)
  User.skip(rand).limit(1).first
end

p "Creating users..."

@lewis = User.new do |u|
  u.username = "lewisf"
  u.email = "lewis.f.chung@gmail.com"
  u.password = "foobar"
  u.password_confirmation = "foobar"
  u.profile = Profile.new do |p|
    p.first_name = "Lewis"
    p.last_name = "Chung"
    p.tagline = "Life is goooooood."
  end
end
@lewis.save!
p "Created Lewis"

@jon_p = Profile.new(first_name: "Jon",
                     last_name: "Wong",
                     tagline: "Wat")

@jon = User.new do |u|
  u.username = "jnwng"
  u.email = "j@jnwng.com"
  u.password = "foobar"
  u.password_confirmation = "foobar"
  u.profile = @jon_p
end
@jon.save!
p "Created Jon"

@wes_p = Profile.new(first_name: "Wes",
                     last_name: "Vetter",
                     tagline: "Im gonna shoot you!")

@wes = User.new do |u| 
  u.username = "wes.vetter"
  u.email = "wes.vetter@gmail.com"
  u.password = "foobar"
  u.password_confirmation = "foobar"
  u.profile = @wes_p
end
@wes.save!
p "Created Wes"

@phi_p = Profile.new(first_name: "Phi",
                     last_name: "Le",
                     tagline: "Booooooooooooo")

@phi = User.new do |u| 
  u.username = "vietataru"
  u.email = "vietataru@gmail.com"
  u.password = "foobar"
  u.password_confirmation = "foobar"
  u.profile = @phi_p
end
@phi.save!
p "Created Phi"

@gylmar_p = Profile.new(first_name: "Gylmar",
                        last_name: "Moreno",
                        tagline: "Booooooooooooo")

@gylmar = User.new do |u| 
  u.username = "gylmar"
  u.email = "morenonomore@gmail.com"
  u.password = "foobar"
  u.password_confirmation = "foobar"
  u.profile = @gylmar_p
end
@gylmar.save!
p "Created Gylmar"

p "Creating recipes ..."
Recipe.create do |recipe|
  recipe.name = "Spaghetti and Meatballs"
  recipe.photo = "http://mda.bigoven.com/pics/rs/256/cheesy-meatballs-with-spaghetti-2.jpg"
  recipe.description = "For the best texture, don't overwork the meat mixture and use Parmesan that's ground to a fine powder 
  (use the processor or the rasp side of a box grater). For more heat, add 1/2 to 3/4 teaspoon dried crushed red pepper to the sauce."
  recipe.prep_time = 10.to_s
  recipe.cook_time = 25.to_s
  recipe.ready_in = 35.to_s
  recipe.serving_size = 6.to_s
  recipe.steps.new do |recipe|
    recipe.description = "Preheat oven to 425 degrees Fahrenheit Place a large pot of water on the stove and heat until boiling, and cook pasta to al dente"
    recipe.start_time = 0
    recipe.end_time = 1
  end
  recipe.steps.new do |recipe|
    recipe.description = "Mix beef and Worcestershire, egg, bread crumbs, cheese, garlic, salt, and pepper. Roll meat into 1 1/2 inch medium-sized meatballs and place on nonstick cookie sheet or a cookie sheet greased with extra-virgin olive oil."
    recipe.start_time = 1
    recipe.end_time = 5
  end
  recipe.steps.new do |recipe|
    recipe.description = "Bake balls for 10 to 12 minutes, until no longer pink."
    recipe.start_time = 5
    recipe.end_time = 16
  end
  recipe.steps.new do |recipe|
    recipe.description = "Heat a deep skillet or medium pot over moderate heat. Add oil, crushed pepper, garlic, and finely chopped onion. Saute 5 to 7 minutes, until onion bits are soft."
    recipe.start_time = 6
    recipe.end_time = 13
  end
  recipe.steps.new do |recipe|
    recipe.description = "Add beef stock, crushed tomatoes and herbs. Bring to a simmer and cook for about 10 minutes."
    recipe.start_time = 12
    recipe.end_time = 22
  end
  recipe.steps.new do |recipe|
    recipe.description = "Take pasta off heat and drain using strainer."
    recipe.start_time = 15
    recipe.end_time = 16
  end
  recipe.steps.new do |recipe|
    recipe.description = "Toss hot, drained pasta in a few ladles of sauce and grated cheese. Turn meatballs in remaining sauce."
    recipe.start_time = 22
    recipe.end_time = 24
  end
  recipe.steps.new do |recipe|
    recipe.description = "Serve!"
    recipe.start_time = 25
    recipe.end_time = 25
  end
  recipe.author = @lewis
end
p "Created Spaghetti and meatballs"

100.times do
  name = Faker::Lorem.sentence(word_count = 2, supplemental = true)
  @recipe = Recipe.create! do |recipe|
    recipe.name = name
    recipe.published = true
    recipe.photo = "http://placekitten.com/190/190"
    recipe.description = Faker::Lorem.sentence(word_count = 4, supplemental = false)
    10.times do
      recipe.recipe_ingredients.new do |ingredient|
        ingredient.name = Faker::Lorem.sentence(word_count = 1, supplemental = false)
        ingredient.amount = ['1/4', '1/3', '1/2', '1', '1 1/2', '1 1/4', '1 1/3', '2'].sample
        ingredient.unit = ['tbsp', 'tsp', 'cup', 'lb'].sample
      end
    end
    5.times do
      recipe.steps.new do |step|
        step.description = Faker::Lorem.sentence(word_count = 4, supplemental = false)
        times = [[0,5], [5,10], [10,15], [0,15], [15,30], [10,20], [15,45], [30,45], [40,45], [45,60]]
        step.start_time, step.end_time = times.sample
      end
    end
    recipe.prep_time = Random.new.rand(10..40)
    recipe.cook_time = Random.new.rand(10..40)
    recipe.ready_in = (recipe.prep_time.to_i + recipe.cook_time.to_i + Random.new.rand(10..20)).to_s
    recipe.serving_size = Random.new.rand(1..6)
    recipe.author = random_user
  end
  p "Created #{name}"
end

