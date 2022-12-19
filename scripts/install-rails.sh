#!/usr/bin/env bash
EXPLAIN_STYLE="\033[1;93m"
NO_STYLE="\033[0m"

function explain() {
    echo -e "\n${EXPLAIN_STYLE}${1}${NO_STYLE}"
}

safelyrun=echo

if [[ "${1}" == "--execute" ]]; then
    safelyrun=''
else
    safelyrun=echo
fi

# Based off of: https://www.railstutorial.org/book
explain "Setting up environment"
$safelyrun echo "gem: --no-document" >> ~/.gemrc
$safelyrun gem install rails -v 7.0.4
$safelyrun gem install bundler -v 2.3.14

explain "Create the app"
$safelyrun rails new tutorial-app --skip-bundle

explain "Install prerequisites"
$safelyrun cd tutorial-app
$safelyrun bundle install

explain "Install local gems without production gems"
$safelyrun bundle config set --local without 'production'
$safelyrun bundle install
$safelyrun bundle lock --add-platform x86_64-linux

explain "Generating user resource"
$safelyrun rails generate scaffold User name:string email:string
$safelyrun rails db:migrate

explain "Generating micropost resource"
$safelyrun rails generate scaffold Micropost content:text user_id:integer
$safelyrun rails db:migrate

explain "Adding a static page controller"
$safelyrun rails generate controller StaticPages home help