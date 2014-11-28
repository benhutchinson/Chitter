require 'spec_helper'

feature "User wants to sign out" do 

  before(:each) {
    User.create(:id => "1",
                :name => "Ben",
                :username => "bendev",
                :email => "test@test.com",
                :password => "test")
  }

  scenario 'and is currently signed in' do
    visit '/'
    click_link('SIGN-IN')
    fill_in 'username', :with => 'bendev'
    fill_in 'password', :with => "test"
    click_button('SIGN-IN')
    click_link('SIGN-OUT')
    expect(page).to have_content("Signed out - don't forget to sign back in if you want to peep")
  end

  scenario 'but is not currently signed in' do
    visit '/'
    expect(page).not_to have_content("SIGN-OUT")
  end

end