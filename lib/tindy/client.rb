module Tindy
  class Client
    include HTTParty

    BASE_ENDPOINT = 'https://api.gotinder.com'.freeze
    TINDER_APP_ID = '464891386855067'.freeze

    REPORT_OPTIONS = {
      spam: 1,
      offensive: 2,
      inappropriate: 2
    }.freeze

    GENDER_OPTIONS = {
      male: 0,
      female: 1
    }.freeze

    def initialize(fb_token)
      @token = authenticate(fb_token)
    end

    def like(id)
      post("/like/#{id}")
    end

    def pass
      post("/pass/#{id}")
    end

    def updates
      post('/updates', { last_activity_date: '' }.to_json)
    end

    def recommendations
      post('/recs')
    end

    def report_user(id, cause)
      raise 'Incorrect cause provided (:spam, :offensive/:inappropriate)' unless REPORT_OPTIONS.key?(cause)

      post("/report/#{id}", { cause: REPORT_OPTIONS.dig(cause) }.to_json)
    end

    def send_message(id, message)
      post("/matches/#{id}", { message: message }.to_json)
    end

    def update_location(latitude, longitude)
      post('/user/ping', { lat: latitude, lon: longitude }.to_json)
    end

    def update_gender(gender)
      raise 'Incorrect gender provided (:male or :female)' unless GENDER_OPTIONS.key?(gender)

      update_profile(gender: GENDER_OPTIONS.dig(gender))
    end

    def update_min_age(age)
      update_profile(age_filter_min: age)
    end

    def update_max_age(age)
      update_profile(age_filter_max: age)
    end

    def update_distance(distance)
      update_profile(distance_filter: distance)
    end

    def update_profile(options = {})
      post('/profile', options.to_json)
    end

    private
    def authenticate(fb_token)
      auth_obj = {
        facebook_token: fb_token,
        facebook_id: TINDER_APP_ID
      }.to_json

      res = post('/auth', auth_obj)

      raise "Failed to authenticate. Response body: #{res.body}" if res.code != 200

      JSON.parse(res.body).dig('token')
    end

    def post(path, body = '')
      res = with_retries { self.class.post(BASE_ENDPOINT + path, headers: headers, body: body) }
      res.parsed_response
    end

    def headers
      headers = {}

      headers['X-Auth-Token'] = @token if defined?(@token)
      headers['content-type'] = 'application/json'
      headers['User-agent'] = 'Tinder/4.0.9 (iPhone; iOS 8.1.1; Scale/2.00)'
      headers['platform'] = 'ios'

      headers
    end
  end
end
