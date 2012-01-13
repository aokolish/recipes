Factory.define :user do |f|
  f.sequence(:email) { |n| "awesomesauce#{n}@example.com" }
  f.password "asdf"
end

Factory.define :recipe do |f|
  f.sequence(:title) { |n| "Awesome Soup no. #{n}"}
  f.author "Swedish Chef"
  f.directions "cut things up|heat things|stir things|enjoy"
  f.ingredients "2 carrots|1 onion|1 pound stew meat"
end

