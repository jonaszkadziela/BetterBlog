# BetterBlog
![CircleCI Status](https://circleci.com/gh/jonaszkadziela/BetterBlog/tree/master.svg?style=shield)

Simple & lightweight blogging application written in Ruby on Rails.

## A few words of introduction:
This project was created as a part of learning Ruby on Rails during a monthly internship at [Ragnarson](https://ragnarson.com/).
The website is completely responsive thanks to Bootstrap, so it will fit every device & screen size.

## Main features:
* Customised authentication (users can log in using username or email)
* Basic authorization
* Users can create, edit & delete posts
* Users can create, edit & delete comments
* List of all the posts is divided into subpages (pagination)
* Both posts and comments support Markdown
* Pleasing website layout & UI
* Comments are added & updated in real-time
* Many automated tests

## Some of the technologies used in BetterBlog:
* Ruby
* Ruby on Rails
* PostgreSQL
* Haml
* Sass
* Bootstrap
* ActionCable (WebSockets)

## Prerequisites:
* Ruby
* Ruby on Rails
* PostgreSQL

## How to setup?
1. Clone the repository
	```
	$ git clone "https://github.com/jonaszkadziela/BetterBlog.git"
	```
1. Enter BetterBlog project directory
	```
	$ cd BetterBlog
	```
1. Setup **.env** file in root directory of the project by copying the example. Be sure to fill in the contents of this file after copying.
	```
	$ cp .env.example .env
	```
1. Install all dependencies
	```
	$ bundle install
	```
1. Setup database
	```
	$ rails db:create
	$ rails db:migrate
	```
1. Run the rails project
	```
	$ rails server
	```
1. Access BetterBlog through the browser

	[Click here to open BetterBlog](http://localhost:3000/)

## Links:
* [Live demo website](https://betterblog.herokuapp.com/)
