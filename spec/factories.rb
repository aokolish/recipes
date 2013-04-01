FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "awesomesauce#{n}@example.com" }
    sequence(:username) { |n| "joebob#{n}" }
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
      after(:create) do |recipe|
        FactoryGirl.create_list(:picture, 2, :imageable => recipe)
      end
    end
  end

  factory :favorite do
    recipe
    user
  end

  factory :picture do
    sequence(:caption) { |n| "interesting caption #{n}" }
    sequence(:position) { |n| "#{n}" }
    imageable_type "Recipe"
    sequence(:image) do |n|
      File.open(File.join(Rails.root, 'spec', 'images', images[n-1]))
    end
  end
end
