## Laravel Website

This is the source of the official Laravel.com website.

The site has two main sections. The front / marketing page which is located at `resources/views/marketing.blade.php` and the documentation pages.

### Documentation

The website's documentation is loaded from the `resources/docs` directory. You will need to clone each version of the documentation into this directory. For example, `resources/docs/5.3`, etc. All of the documentation is stored on GitHub at [laravel/docs](https://github.com/laravel/docs).

### Docker
Run the Composer Command

    docker-compose run --rm -w /var/www/html app composer install

We'll need an APP_KEY as well for the .env file:

    docker-compose run --rm -w /var/www/html app php artisan key:generate

Redis Library

    docker-compose run --rm -w /var/www/html app composer require predis/predis

npm

    docker-compose run --rm -w /var/www/html node npm install

gulp

    docker-compose run --rm -w /var/www/html node ./node_modules/.bin/gulp

Then we can spin up our containers to run this in development:

    docker-compose up -d

Check out our containers:

    docker-compose ps

Add docs (5.4):

    cd resources/docs/5.4
    git clone https://github.com/laravel/docs.git .
