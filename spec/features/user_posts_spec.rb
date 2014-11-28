require 'spec_helper'

feature "User decides to post" do 

  before(:each) {

    User.create(:id => "1",
                :name => "Ben",
                :username => "bendev",
                :email => "test@test.com",
                :password => "test")

    Post.create(:message => "I love Chitter. Who said comments are dead?",
                :time => Time.now,
                :user_id => "1")

  }

  scenario "and is signed-in" do 
    visit '/'
    click_link 'SIGN-IN'
    fill_in 'username', :with => 'bendev'
    fill_in 'password', :with => "test"
    click_button('SIGN-IN')
    click_link 'POST'
    page.has_field?("message", :type => "textarea")
    fill_in("message", :with => "Capybara Post")
    click_button('POST')
    expect(page).to have_content("Capybara")
  end

  scenario "but is not signed-in" do 
    visit '/'
    click_link 'SIGN-IN'
    fill_in 'username', :with => 'bendev'
    fill_in 'password', :with => "test"
    click_button('SIGN-IN')
    click_link 'SIGN-OUT'
    expect(page).not_to have_content("SIGN-OUT")
  end

end