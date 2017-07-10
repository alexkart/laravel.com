#!/bin/bash

# Make sure we have our default command
#./develop

# Make sure we pass-thru to docker-compose for
# un-defined helpers
#./develop ps
#./develop up -d

# Install composer deps
#./develop composer install

# Run phpunit
#./develop test

# Install node_modules dependencies
#./develop npm install

# Run gulp tasks
#./develop gulp


# Set environment variables for dev
export APP_ENV=${APP_ENV:-local}
export APP_PORT=${APP_PORT:-80}
export DB_ROOT_PASS=${DB_ROOT_PASS:-secret}
export DB_NAME=${DB_NAME:-helpspot}
export DB_USER=${DB_USER:-helpspot}
export DB_PASS=${DB_PASS:-secret}

COMPOSE="docker-compose"

# If we pass any arguments...
if [ $# -gt 0 ];then

    # If "art" is used, pass-thru to "artisan"
    # inside a new container
    if [ "$1" == "art" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /var/www/html \
            app \
            php artisan "$@"

    # If "composer" is used, pass-thru to "composer"
    # inside a new container
    elif [ "$1" == "composer" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /var/www/html \
            app \
            composer "$@"

    # If "test" is used, run unit tests,
    # pass-thru any extra arguments to php-unit
    elif [ "$1" == "test" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /var/www/html \
            app \
            ./vendor/bin/phpunit "$@"

    # If "npm" is used, run npm
    # from our node container
    elif [ "$1" == "npm" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /var/www/html \
            node \
            npm "$@"

    # If "gulp" is used, run gulp
    # from our node container
    elif [ "$1" == "gulp" ]; then
        shift 1
        $COMPOSE run --rm \
            -w /var/www/html \
            node \
            ./node_modules/.bin/gulp "$@"
    # Else, pass-thru args to docker-compose
    else
        $COMPOSE "$@"
    fi

else
    $COMPOSE ps
fi