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
  u.username = "lewisf",
  u.email = "lewis.f.chung@gmail.com",
  u.password = "foobar",
  u.password_confirmation = "foobar",
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
  recipe.photo = "http://www.imgur.com/19fdj2.png"
  recipe.description = "Scrumptious fresh budget spaghetti and meatballs recipe"
  recipe.prep_time = 30
  recipe.cook_time = 30
  recipe.ready_in = 60
  recipe.serving_size = 4
  recipe.author = @lewis
end
p "Created Spaghetti and meatballs"

100.times do
  name = Faker::Lorem.sentence(word_count = 2, supplemental = true)
  @recipe = Recipe.create! do |recipe|
    recipe.name = name
    recipe.published = true
    recipe.photo = "http://placekitten.com/300/300"
    recipe.description = Faker::Lorem.sentence(word_count = 4, supplemental = false)
    recipe.prep_time = Random.new.rand(10..40)
    recipe.cook_time = Random.new.rand(10..40)
    recipe.ready_in = recipe.prep_time + recipe.cook_time + Random.new.rand(10..20)
    recipe.serving_size = Random.new.rand(1..6)
    recipe.author = random_user
  end
  p "Created #{name}"
end

