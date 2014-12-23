require 'spec_helper'

feature "User wants to reset password" do 

  before(:each) {
    User.create(:id => "1",
                :name => "Ben",
                :username => "bendev",
                :email => "test@test.com",
                :password => "test",
                :password_token => "dummytoken")
  }

  scenario 'and asks for email reminder having forgotten current password' do
    visit '/'
    click_link('SIGN-IN')
    click_link('FORGOT PASSWORD')
    fill_in 'email', :with => "test@test.com"
    click_button('SUBMIT')
    expect(page).to have_content("Thank you. Please check your email shortly.")
  end

  scenario 'and subsequently goes to reset their password' do
    visit '/reset_password/dummytoken'
    fill_in 'password', :with => "newpassword"
    click_button('RESET MY PASSWORD')
  end

end