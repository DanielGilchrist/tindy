# tindy
A shitty ruby client for Tinder (using [this doc](https://gist.github.com/rtt/10403467) as a reference)  

## Installation

Bundler

```
gem 'tindy'
```

Other

```
[sudo|rvm] gem install tindy
``` 

## Getting Started
Require tindy and initialize the client with your Facebook access token ([instructions](https://gist.github.com/taseppa/66fc7239c66ef285ecb28b400b556938))

```
require 'tindy'

tindy = Tindy::Client.new("YOUR_FACEBOOK_ACCESS_TOKEN")
```

### Recommendations
Returns a list of recommended Tinder users

```
tindy.recommendations
```

### Like/Pass
Like or pass a user
```
# like user
tindy.like(12345)

# pass user
tindy.pass(12345)
```

### Updates
Get recent updates
```
tindy.updates
```
### Report Users
Report a user
```
# report a user for spam
tindy.report_user(12345, :spam)

# report a user for being offensive/inappropriate
tindy.report_user(12345, :offensive)
tindy.report_user(12345, :inappropriate)
```

### Send Message
(I haven't tested if this works)  
Send a message to one of your matches
```
tindy.send_message(12345, "Hey how are you?")
```

### Update Location
Update your location
```
tindy.update_location(-27.469770, 153.025131)
```

### Update Profile
Update your profile either individually or multiple at once
```
# update multiple (gender: <0|1>, age_filter_min: <number>, age_filter_max: <number>, update_distance: <number>
tindy.update_profile(age_filter_min: 20, age_filter_max: 26)

# update gender
tindy.update_gender(:male)
tindy.update_gender(:female)

# update minumum age
tindy.update_min_age(20)

# update maximum age
tindy.update_max_age(26)

# update distance (km)
tindy.update_distance(15)
```

## Future Plans
I'm not really taking this gem that seriously but I may add in more functionality, tests (lmao), and whatever else if I find the time.

## Contributing

Just schmang up a PR and I'll check it out

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
Couldn't have been build without [this doc](https://gist.github.com/rtt/10403467) and the people commenting on it <3
