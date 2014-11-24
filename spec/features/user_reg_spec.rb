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
    
  end

end