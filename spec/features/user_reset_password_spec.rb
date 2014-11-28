require 'spec_helper'

feature "User wants to reset password" do 

  before(:each) {
    User.create(:id => "1",
                :name => "Ben",
                :username => "bendev",
                :email => "test@test.com",
                :password => "test")
  }

  scenario 'and has forgotten current password' do
    visit '/'
    click_link('SIGN-IN')
    click_link('FORGOT PASSWORD')
    expect(page).to have_content("PLEASE ENTER YOUR EMAIL ADDRESS")
  end

end