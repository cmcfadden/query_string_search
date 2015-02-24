# Query String Search 
[![Build Status](https://api.travis-ci.org/umn-asr/query_string_search.svg?branch=master)](https://travis-ci.org/umn-asr/query_string_search) 
[![Code Climate](https://codeclimate.com/github/umn-asr/query_string_search/badges/gpa.svg)](https://codeclimate.com/github/umn-asr/query_string_search)
[![Gem Version](https://badge.fury.io/rb/query_string_search.svg)](http://badge.fury.io/rb/query_string_search)

Provides an easy way to implement searching in your API endpoints

## Searches it supports

Say you have a `movies` endpoint and people want to be able to search your huge collection of movie data. Each of your movies have these properties

- Rating: returns "PG", "R", etc. Can also return nil
- Year: returns the year the film was released
- Title: The movie's title
- Star Rating: returns a number 1 to 5
- Home Formats: returns an array of available home formats. `["DVD", "BD"]`, for example.

The API Search gem will give you the following search functionality:

Query String Example  | What Data is Returned
------------- | -------------
`movies` | All data in your data set
`movies?q=rating=all` | Movies with a non-nil rating
`movies?q=rating=none` | Movies with a nil rating
`movies?q=year=1994` | Movies with a year of 1994
`movies?q=year=1994|1995` | Movies with a year of 1994 or 1995
`movies?q=title=Dunston%20Checks%20In` | Movies with the title Dunston Checks In
`movies?q=star_rating>1` | Movies with a star rating greater than one
`movies?q=star_rating<3` | Movies with a star rating less than three
`movies?q=star_rating>=2` | Movies with a star rating greater than or equal to 2
`movies?q=star_rating<=4` | Movies with a star rating less than or equal to 4
`movies?q=home_formats=DVD` | Movies that are available on DVD.
`movies?q=home_formats=DVD|BD` | Movies that are available on DVD or Blu Ray

### Combining Searches

Any of the above critera can be combined. 
Just separate criteria with commas. 
Records that match **all** the criteria will be returned. 
Some examples!

`movie?q=year=1994,country=US,rated=none`<br />
 All un-rated movies made in the US in 1994.

`movie?q=home_formats=BD|DVD,rated=R|PG,star_rating>3`<br />
All movies available on BD or DVD, that are rated R or PG, and that have a star rating greater than 3

## Usage

First, create a collection of data. With ActiveRecord or other ORMs this is straightforward:

```ruby
Movie.all
```

Or something similar. As long as it returns a collection of objects, you should be good.

The objects must respond to the attributes you want to search on. Say you want to allow a search string like this:

`movies?q=year=1994`

Then every object in your data collection needs to respond to `year`.

Second, search! In Rails you can do something like this in a Controller method.

```ruby
def index
  query_string = params[:q]
  QueryStringSearch.new(Movie.all, query_string).results
  #....
end
```

This returns a collection of the objects that matched the search criteria.

Or you can do it not in the controller. This will work:

```ruby
QueryStringSearch.new(Movie.all, "country=us").results
```

You get the idea. Pass in a data set and a query-stringish string and you'll get results back.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'query_string_search'
```

And then execute:

    $ bundle


## Contributing

- Fork, branch, commit & pull.
- Tests are required.
- Don't go against our Rubocop style guidelines.

## License

© Regents of the University of Minnesota. All rights reserved.
