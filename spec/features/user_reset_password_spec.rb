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

  scenario 'and has forgotten current password' do
    visit '/'
    click_link('SIGN-IN')
    click_link('FORGOT PASSWORD')
    expect(page).to have_content("PLEASE ENTER YOUR EMAIL ADDRESS")
    fill_in 'email', :with => "test@test.com"
    click_button('SUBMIT')
    expect(page).to have_content("Thank you. Please check your email shortly.")
    visit '/reset_password/dummytoken'
    expect(page).to have_content("PLEASE ENTER A NEW PASSWORD")
    fill_in 'password', :with => "newpassword"
    click_button('RESET MY PASSWORD')
  end

end