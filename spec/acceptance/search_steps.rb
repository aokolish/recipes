step 'three recipes come up in my search results' do
  3.times do |n|
    FactoryGirl.create(:recipe,
                       :created_at => n.days.ago,
                       :title => "recipe no #{n}",
                       :ingredients => 'cheese')
  end
  visit search_recipes_path(:search => 'cheese')
end

step 'I click the :button sort button' do |button|
  click_link(button)
end

step 'the search results should be ordered by date created :direction' do |direction|
  if direction == 'descending'
    page.find('#results li:first-child').should have_content('recipe no 0')
  else
    page.find('#results li:first-child').should have_content('recipe no 2')
  end
end

step 'when I click it again' do
  step "I click the 'Created At' sort button"
end

step 'I should see the original search results' do
  page.find('#results li:first-child').should have_content('recipe no 0')
  page.find('#results li:last-child').should have_content('recipe no 2')
end
