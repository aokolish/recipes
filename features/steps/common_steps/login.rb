module CommonSteps
  module Login
    extend ActiveSupport::Concern

    included do
      Given 'a user exists' do
        self.user = FactoryGirl.create(:user)
      end

      And 'I am logged in' do
        self.user = FactoryGirl.create(:user)

        visit login_path
        fill_in "email", :with => user.email
        fill_in "password", :with => user.password
        click_button "Log in"
      end
    end
  end
end
