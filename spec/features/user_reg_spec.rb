require 'spec_helper'

feature "User wants to sign up" do 

  before(:each) {
    User.create(:name => "Ben",
                :username => "bendev",
                :email => "test@test.com",
                :password => "test")
    }

  scenario "with unique credentials" do 
    visit '/'
    click_link('REGISTER')
    fill_in 'email', :with => 'ming@chan.com'
    fill_in 'name', :with => 'Ming'
    fill_in 'username', :with => 'mingchan'
    fill_in 'password', :with => 'mchan'
    click_button 'SIGN-UP'
    expect(page).to have_content("Welcome to the party.")
  end

  scenario "but someone else has already taken that username" do 
    visit '/'
    expect(User.count).to be 1
    click_link('REGISTER')
    fill_in 'username', :with => 'bendev'
    click_button 'SIGN-UP'
    expect(User.count).to be 1 # to show user not written to database
    expect(page).to have_content("Sorry. That username has already been taken.  Please choose another one.")
  end

  # scenario "but someone else has already signed up with that email" do 

  # end

end