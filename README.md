# Sinatra_Project

This application is for the Flatiron Sinatra Portfolio Project. This app brings together Sinatra and ActiveRecord to have user entered data persist in a database that ActiveRecord created and display them using Sinatra on an internet browser. The project is a database for a gamer's video game collection. They are required to create a username and login to their account. The gamer can create, read, update, and delete (CRUD) entries for their own account.

## Getting Started

    1. Clone this repository
    2. Gems required
        • sinatra
        • activerecord version 4.2.6 or higher
        • sinatra-activerecord
        • rake
        • require_all version 1.3.6
        • thin
        • shotgun
        • pry
        • bcrypt
        • tux
        • sinatra-flash
        • dotenv
        • rspec
        • capybara
        • rack-test
        • database_cleaner
    3. Run bundle install to install gems
    4. Create a .env file with a line of code starting with SESSION_SECRET = "(type your own secret code)"
    5. Run rake db:migrate to create database tables
    6. Run shotgun and goto designated url

## Contributing

Bug reports and pull requests are welcomed on [GitHub](https://github.com/Dice-K39/Sinatra_Project).

## License

This project is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT). A [copy of the license](/LICENSE) is with cloned with this project.
