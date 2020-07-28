# tindy
A Ruby client for Tinder (made using [this doc](https://gist.github.com/rtt/10403467) as a reference)  

## Installation

Bundler

```ruby
gem 'tindy'
```

Other

```ruby
[sudo|rvm] gem install tindy
``` 

## Getting Started
Require tindy and initialize the client with your Facebook access token ([instructions](https://gist.github.com/taseppa/66fc7239c66ef285ecb28b400b556938))

```ruby
require 'tindy'

tindy = Tindy::Client.new("YOUR_FACEBOOK_ACCESS_TOKEN")
tindy.authenticate!
```

### Update Location
Update your location
```ruby
tindy.update_location(-27.469770, 153.025131)
```

### Update Profile
Update your profile either individually or multiple at once
```ruby
# update multiple (gender: <0|1> or <:male|:female>, age_filter_min: <number>, age_filter_max: <number>, distance_filter: <number>
tindy.update_profile(age_filter_min: 20, age_filter_max: 26)

# update gender
tindy.update_gender(:male)
tindy.update_gender(:female)

# update minimum age
tindy.update_min_age(20)

# update maximum age
tindy.update_max_age(26)

# update distance (km)
tindy.update_distance(15)
```

### Like/Pass
Like or pass a user
```ruby
# like user (_id)
tindy.like("53467235483cb56c475cc1d6")

# pass user (_id)
tindy.pass("53467235483cb56c475cc1d6")
```
##### Example Response
```ruby
{
  "match" => true
}
```

### Send Message
Send a message to one of your matches (_id)
```ruby
tindy.send_message("53467235483cb56c475cc1d6", "Hey how are you?")
```
##### Example Response
```ruby
{
  "_id" => "53467235483cb56c475cc1d6",
  "from" => "53430689ab3c04c13e006ffb",
  "to" => "533a59ea52046fc077002815",
  "match_id" => "53464b0728ac73976d0a3fbf",
  "sent_date" => "2014-04-10T10:28:05.764Z",
  "message" => "hi!",
  "created_date" => "2014-04-10T10:28:05.764Z"
}
```

### Report Users
Report a user
```ruby
# report a user for spam (_id)
tindy.report_user("53467235483cb56c475cc1d6", :spam)

# report a user for being offensive/inappropriate
tindy.report_user("53467235483cb56c475cc1d6", :offensive)
tindy.report_user("53467235483cb56c475cc1d6", :inappropriate)
```

### Updates
Get recent updates
```ruby
tindy.updates
```
##### Example Response
```ruby
{
  "matches" => [{
    "_id" => "53464b0728ac73976d0a3fbf",
    "messages" => [{
      "_id" => "534651198ce6da797248c1a3",
      "match_id" => "53464b0728ac73976d0a3fbf",
      "to" => "53430689ab3c04c13e006ffb",
      "from" => "533a59ea52046fc077002815",
      "message" => "hi  .... how is it going?",
      "sent_date" => "2014-04-10T08:06:49.800Z",
      "created_date" => "2014-04-10T08:06:49.800Z",
      "timestamp" => 1397117209800
    }],
    "last_activity_date" => "2014-04-10T10:17:54.379Z"
  }],
  "blocks" => [],
  "lists" => [],
  "deleted_lists" => [],
  "last_activity_date" => "2014-04-10T10:17:54.379Z"
}
```

### Recommendations
Returns a list of recommended Tinder users
```ruby
tindy.recommendations
```
##### Example Response
```ruby
{
  "status" => 200,
  "results" => [{
    "distance_mi" => 2,
    "common_like_count" => 0,
    "common_friend_count" => 0,
    "common_likes" => [],
    "common_friends" => [],
    "_id" => "518d666a2a00df0e490000b9",
    "bio" => "",
    "birth_date" => "1986-05-17T00:00:00.000Z",
    "gender" => 1,
    "name" => "Elen",
    "ping_time" => "2014-04-08T11:59:18.494Z",
    "photos" => [{
        "id" => "fea4f480-7ce0-4143-a310-a03c2b2cdbc6",
        "main" => true,
        "crop" => "source",
        "fileName" => "fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg",
        "extension" => "jpg",
        "processedFiles" => [{
            "width" => 640,
            "height" => 640,
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/640x640_fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg"
          },
          {
            "width" => 320,
            "height" => 320,
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/320x320_fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg"
          },
          {
            "width" => 172,
            "height" => 172,
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/172x172_fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg"
          },
          {
            "width" => 84,
            "height" => 84,
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/84x84_fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg"
          }
        ],
        "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/fea4f480-7ce0-4143-a310-a03c2b2cdbc6.jpg"
      },
      {
        "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/5c1d3231-5a75-4a07-91ff-5c012716583f.jpg",
        "processedFiles" => [{
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/640x640_pct_0_29.5312464_540_540_5c1d3231-5a75-4a07-91ff-5c012716583f.jpg",
            "height" => 640,
            "width" => 640
          },
          {
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/320x320_pct_0_29.5312464_540_540_5c1d3231-5a75-4a07-91ff-5c012716583f.jpg",
            "height" => 320,
            "width" => 320
          },
          {
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/172x172_pct_0_29.5312464_540_540_5c1d3231-5a75-4a07-91ff-5c012716583f.jpg",
            "height" => 172,
            "width" => 172
          },
          {
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/84x84_pct_0_29.5312464_540_540_5c1d3231-5a75-4a07-91ff-5c012716583f.jpg",
            "height" => 84,
            "width" => 84
          }
        ],
        "extension" => "jpg",
        "fileName" => "5c1d3231-5a75-4a07-91ff-5c012716583f.jpg",
        "main" => false,
        "ydistance_percent" => 0.75,
        "yoffset_percent" => 0.04101562,
        "xoffset_percent" => 0,
        "id" => "5c1d3231-5a75-4a07-91ff-5c012716583f",
        "xdistance_percent" => 1
      },
      {
        "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/5abd87e5-a181-4946-a8b9-880926a78943.jpg",
        "processedFiles" => [{
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/640x640_pct_0_118.125_540_540_5abd87e5-a181-4946-a8b9-880926a78943.jpg",
            "height" => 640,
            "width" => 640
          },
          {
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/320x320_pct_0_118.125_540_540_5abd87e5-a181-4946-a8b9-880926a78943.jpg",
            "height" => 320,
            "width" => 320
          },
          {
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/172x172_pct_0_118.125_540_540_5abd87e5-a181-4946-a8b9-880926a78943.jpg",
            "height" => 172,
            "width" => 172
          },
          {
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/84x84_pct_0_118.125_540_540_5abd87e5-a181-4946-a8b9-880926a78943.jpg",
            "height" => 84,
            "width" => 84
          }
        ],
        "extension" => "jpg",
        "fileName" => "5abd87e5-a181-4946-a8b9-880926a78943.jpg",
        "main" => false,
        "ydistance_percent" => 0.75,
        "yoffset_percent" => 0.1640625,
        "xoffset_percent" => 0,
        "id" => "5abd87e5-a181-4946-a8b9-880926a78943",
        "xdistance_percent" => 1
      },
      {
        "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/5e168698-a034-40c0-b7fb-7c05743f2310.jpg",
        "processedFiles" => [{
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/640x640_pct_157.570344_0_405_405_5e168698-a034-40c0-b7fb-7c05743f2310.jpg",
            "height" => 640,
            "width" => 640
          },
          {
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/320x320_pct_157.570344_0_405_405_5e168698-a034-40c0-b7fb-7c05743f2310.jpg",
            "height" => 320,
            "width" => 320
          },
          {
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/172x172_pct_157.570344_0_405_405_5e168698-a034-40c0-b7fb-7c05743f2310.jpg",
            "height" => 172,
            "width" => 172
          },
          {
            "url" => "http://images.gotinder.com/518d666a2a00df0e490000b9/84x84_pct_157.570344_0_405_405_5e168698-a034-40c0-b7fb-7c05743f2310.jpg",
            "height" => 84,
            "width" => 84
          }
        ],
        "extension" => "jpg",
        "fileName" => "5e168698-a034-40c0-b7fb-7c05743f2310.jpg",
        "main" => false,
        "ydistance_percent" => 1,
        "yoffset_percent" => 0,
        "xoffset_percent" => 0.2188477,
        "id" => "5e168698-a034-40c0-b7fb-7c05743f2310",
        "xdistance_percent" => 0.5625
      }
    ],
    "birth_date_info" => "fuzzy birthdate active, not displaying real birth_date"
  }]
}
```

## Future Plans
I'm not really taking this gem that seriously but I may add in more functionality, tests (lmao), and whatever else if I find the time.

## Contributing

Just schmang up a PR and I'll check it out

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
Couldn't have been built without [this doc](https://gist.github.com/rtt/10403467) and the people commenting on it <3
