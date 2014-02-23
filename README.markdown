Shinson Learning
================

Shinson Learning is a Rails 4 app on Ruby 2.0 and deployed to Heroku.

Development
-----------

### Setup
1. Install PostgreSQL. If you're on a Mac this can be done using the [Postgres app](http://postgresapp.com). If you're on Windows or Linux then you're on your own.

2. Setup [capybara-webkit](https://github.com/thoughtbot/capybara-webkit#capybara-webkit).

3. Make sure you have at least Ruby 2.0.0. If you don't then I recommend [Rbenv](https://github.com/sstephenson/rbenv).

4. Get the code.

    ```
    $ git clone https://github.com/davidpdrsn/Shinson-Learning.git
    ```

5. Setup your environment

    ```
    $ bin/setup
    ```

6. Run the server to check that everything works

    ```
    $ bin/rails server
    ```

    Then visit [http://localhost:3000](http://localhost:3000)
