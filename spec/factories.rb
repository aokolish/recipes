Factory.define :user do |f|
  f.sequence(:email) { |n| "awesomesauce#{n}@example.com" }
  f.password "asdf"
end