FactoryGirl.define do
  factory :recipe do
    name 'Spaghetti and Meatballs'
    photo 'photo.png'
    description 'A delicious, simple, budget Spaghetti and Meatballs recipe'
    association :author, factory: :user, strategy: :build
  end
end
