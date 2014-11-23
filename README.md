Chitter
=======

##Week 4: Weekend Challenge : Databases

This challenge consolidates our experience from the Bookmark Manager task.  It involved a basic Twitter clone that will allow users to post messages to a public stream.  Users will sign up with an email, name, password, and a user-name, and subsequently be able to log-in and log-out.  Names and user-names will be unique and passwords will be secured via BCrypt.  Users must be logged-in in order to post, but any person should be able to view a chronologically-ordered list of posts.  Posts will be labelled with both a name and user-name.  The DataMapper ORM will be deployed to manage data from a PostgreSQL database.  This should conform to test-driven-development philosophies.

###Technologies
- DataMapper with a PostgreSQL Database
- Ruby
- BCrypt
- RSpec, Capybara
- Sinatra-Cucumber
- Heroku Hosting
- HTML/CSS