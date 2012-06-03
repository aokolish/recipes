FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "awesomesauce#{n}@example.com" }
    password "asdf"

    #factory :author do
    #  association :authored_recipes, :factory => :recipe
    #end
  end

  factory :recipe do
    sequence(:title) { |n| "Awesome Soup no. #{n}"}
    author "Swedish Chef"
    directions "cut things up|heat things|stir things|enjoy"
    ingredients "2 carrots|1 onion|1 pound stew meat"
    user

    factory :recipe_with_pictures do
      #after(:create) do |recipe, evaluator|
      #  #FactoryGirl.create_list(:picture, 2, :recipe => recipe)
      #end
    end
  end

  factory :favorite do
    recipe
    user
  end

  factory :picture do
    sequence(:caption) { |n| "interesting caption #{n}" }
    image { fixture_file_upload("spec/images/peppers-at-market.jpg", "image/jpeg") }
    recipe
  end
end
