require 'spec_helper'
require 'orderly'

feature "User visits homepage" do 

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

  scenario "expects to see all the posts" do 
    visit '/'
    expect(page).to have_content("I love Chitter.")
  end

  scenario "and sees newest post first" do 
    visit '/'
    expect(page).to have_content("I love Chitter.")
    Post.create(:message => "Calvin Harris",
                :time => Time.now + 60,
                :user_id => "1")
    p Post.all
    visit '/'
    expect("Calvin").to appear_before("Chitter")
  end

end