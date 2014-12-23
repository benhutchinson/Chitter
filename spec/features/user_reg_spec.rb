require 'spec_helper'

feature "User wants to sign up" do 

  include HelperMethods

  before(:each) {
    create_user
    }

  scenario "with unique credentials" do 
    visit '/'
    click_link('REGISTER')
    fill_in 'email', :with => 'ming@chan.com'
    fill_in 'name', :with => 'Ming'
    fill_in 'username', :with => 'mingchan'
    fill_in 'password', :with => 'mchan'
    click_button 'SIGN-UP'
    expect(page).to have_content("Yo Ming")
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

  scenario "but someone else has already signed up with that email" do 
    visit '/'
    expect(User.count).to be 1
    click_link('REGISTER')
    fill_in 'email', :with => 'test@test.com'
    click_button 'SIGN-UP'
    expect(User.count).to be 1 # to show user not written to database
    expect(page).to have_content("Sorry. That email address has already been used.  Please use another one.")
  end

  scenario "but someone else has already signed up with both that email and username" do 
    visit '/'
    expect(User.count).to be 1
    click_link('REGISTER')
    fill_in 'username', :with => 'bendev'
    fill_in 'email', :with => 'test@test.com'
    click_button 'SIGN-UP'
    expect(User.count).to be 1 # to show user not written to database
    expect(page).to have_content("Both that email and username have  been taken.  Please try something new.")
  end


end