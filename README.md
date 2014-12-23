Chitter
=======

##Week 4: Weekend Challenge : Databases

This challenge consolidated our experience from the Bookmark Manager task.  It involved a basic Twitter clone that allowed users to post messages to a public stream.  The end app is hosted here on [Heroku](https://powerful-eyrie-5942.herokuapp.com/).

###Basic Functionality

Users sign up with an email, name, password, and a user-name, and are subsequently able to log-in and log-out.  Names and user-names are unique and passwords are secured via BCrypt.  Users must be logged-in in order to post, but any person is able to view a chronologically-ordered list of posts.  Posts are labelled with both a name and user-name.  The DataMapper ORM has been deployed to manage data from a PostgreSQL database.  This has been built in accordance with test-driven-development philosophies.

###Refactoring Potential

There is refactoring potential in certain spec tests and controllers could be separated from the central server app file.  I have deliberately chosen to keep things as they are for my ease of reference.

###Feedback From Review & Ways To Improve
- Refactoring per above.
- Many tests appear similar.  A helper module could be established and included into the spec files as appropriate.
- Mailgun is being called in tests and could be stubbed out
- Tests could be more eloquent.  1 test = 1 expectation
- Controllers could be grouped in their own folder
- Animation in index.erb could be extracted into its own script file and called in
- The controller has a lot of logic in it (per above).  Mailgun could be considered for extraction into its own separate class or module.

###Technologies
- DataMapper with a PostgreSQL Database
- Ruby
- BCrypt
- RSpec, Capybara
- Sinatra-Cucumber
- Heroku Hosting
- HTML/CSS
- Orderly Gem