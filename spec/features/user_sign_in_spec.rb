require 'spec_helper'

feature "User wants to sign in" do 

  before(:each) {
    User.create(:id => "1",
                :name => "Ben",
                :username => "bendev",
                :email => "test@test.com",
                :password => "test")
  }

  scenario 'and has the correct credentials' do
    visit '/'
    expect(page).not_to have_content("Hi Ben : Time to Chit Out")
    click_link('SIGN-IN')
    fill_in 'username', :with => 'bendev'
    fill_in 'password', :with => "test"
    click_button('SIGN-IN')
    expect(page).to have_content("Hi Ben : Time to Chit Out")
  end

   scenario 'and does not have the correct credentials' do
    visit '/'
    expect(page).not_to have_content("Hi Ben : Time to Chit Out")
    click_link('SIGN-IN')
    fill_in 'username', :with => 'bendev'
    fill_in 'password', :with => "zebra"
    click_button('SIGN-IN')
    expect(page).to have_content("Sorry, the email or password entered is incorrect.")
  end

end