# README

### Installation

Required software needed to be installed. Instructions below are for mac users who have homebrew installed already.

- Ruby 3.4.1

#### RVM

```
rvm install 3.4.1
rvm use 3.4.1
```

#### Bundler

```
gem install bundler
bundle install
```

### Environmental Variables

Please create a `.env.local` file to set up environmental variables. Required variables can be found in `.env.example`

### Running

#### Server

`./bin/dev`

### Usage

#### General

A list and show page is available for Github issues assigned to the user defined by the personal access token.

Issues can be filtered by `open`, `closed` and `all`

### Testing

`bundle exec rspec`
