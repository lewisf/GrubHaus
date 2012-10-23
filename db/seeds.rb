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

@lewis_p = Profile.new(first_name: "Lewis",
                       last_name: "Chung",
                       tagline: "Life is too good to be wasted coding.")

@lewis = User.create(username: "lewisf",
                     email: "lewis.f.chung@gmail.com",
                     password: "foobar",
                     password_confirmation: "foobar",
                     profile: @lewis_p)

@jon_p = Profile.new(first_name: "Jon",
                     last_name: "Wong",
                     tagline: "Wat")

@jon = User.create(username: "jnwng",
                   email: "j@jnwng.com",
                   password: "foobar",
                   password_confirmation: "foobar",
                   profile: @jon_p)

@wes_p = Profile.new(first_name: "Wes",
                     last_name: "Vetter",
                     tagline: "Im gonna shoot you!")

@wes = User.create(username: "wes.vetter",
                   email: "wes.vetter@gmail.com",
                   password: "foobar",
                   password_confirmation: "foobar",
                   profile: @wes_p)

@phi_p = Profile.new(first_name: "Phi",
                     last_name: "Le",
                     tagline: "Booooooooooooo")

@phi = User.create(username: "vietataru",
                   email: "vietataru@gmail.com",
                   password: "foobar",
                   password_confirmation: "foobar",
                   profile: @phi_p)

@gylmar_p = Profile.new(first_name: "Gylmar",
                        last_name: "Moreno",
                        tagline: "Booooooooooooo")

@gylmar = User.create(username: "gylmar",
                      email: "morenonomore@gmail.com",
                      password: "foobar",
                      password_confirmation: "foobar",
                      profile: @gylmar_p)

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

100.times do
  @recipe = Recipe.create! do |recipe|
    recipe.name = Faker::Name.name
    recipe.photo = Faker::Internet.url
    recipe.description = Faker::Lorem.sentence(word_count = 4, supplemental = false)
    recipe.prep_time = Random.new.rand(10..40)
    recipe.cook_time = Random.new.rand(10..40)
    recipe.ready_in = recipe.prep_time + recipe.cook_time + Random.new.rand(10..20)
    recipe.serving_size = Random.new.rand(1..6)
    recipe.author = random_user
  end
end

