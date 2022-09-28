# DoorkeeperJp

API client for [doorkeeper.jp](https://www.doorkeeper.jp/) 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doorkeeper_jp'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install doorkeeper_jp

## Usage
```ruby
require "doorkeeper_jp"

client = DoorkeeperJp.client(ENV["DOORKEEPER_ACCESS_TOKEN"])

# List all featured events
events = client.events

events.count
#=> 25

events[0].title
#=> "Kaigi on Rails 2022"

events[0].public_url
#=> "https://kaigionrails.doorkeeper.jp/events/143638"

# List a community's events
client.group_events("trbmeetup")

# Show a specific event
event = client.event(28319)

event.title
#=> "900K records per second with Ruby, Java, and JRuby"

event.public_url
#=> "https://trbmeetup.doorkeeper.jp/events/28319"

# Show a specific group
group = client.group("trbmeetup")

group.name
#=> "Tokyo Rubyist Meetup"

group.public_url
#=> "https://trbmeetup.doorkeeper.jp/"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/doorkeeper_jp.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
