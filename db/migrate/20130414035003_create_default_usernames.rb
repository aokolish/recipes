class CreateDefaultUsernames < ActiveRecord::Migration
  def up
    User.all.each_with_index do |user, i|
      if user.username.blank?
        begin
          user.username = "anonymous#{i}"
          user.save!
        rescue ActiveRecord::RecordInvalid
          puts 'this user could not be saved =>'
          p user.attributes
        end
      end
    end
  end
end
