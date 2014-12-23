module HelperMethods

  def create_user
    User.create(:name => "Ben",
                :username => "bendev",
                :email => "test@test.com",
                :password => "test")
  end
end