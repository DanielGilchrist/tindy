module Tindy
  class Client
    include HTTParty

    base_uri "https://api.gotinder.com"

    TINDER_APP_ID = "464891386855067".freeze

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
      @fb_token = fb_token
      @tinder_token = nil
    end

    def authenticate!
      return if authenticated?

      auth_obj = {
        facebook_token: @fb_token,
        facebook_id: TINDER_APP_ID
      }.to_json

      res = self.class.post("/auth", headers: headers, body: auth_obj)

      raise "Failed to authenticate. Response body: #{res.body}" if res.code != 200

      @tinder_token = JSON.parse(res.body)["token"]
    end

    def like(id)
      post("/like/#{id}")
    end

    def pass(id)
      post("/pass/#{id}")
    end

    def updates
      post("/updates", { last_activity_date: "" })
    end

    def recommendations
      post("/recs")
    end

    def report_user(id, cause)
      raise "Incorrect cause provided (:spam, :offensive/:inappropriate)" unless REPORT_OPTIONS.key?(cause)

      post("/report/#{id}", { cause: REPORT_OPTIONS[cause] })
    end

    def send_message(id, message)
      post("/matches/#{id}", { message: message })
    end

    def update_location(latitude, longitude)
      post("/user/ping", { lat: latitude, lon: longitude })
    end

    def update_gender(gender)
      update_profile(gender: gender)
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
      gender_option = options[:gender]
      validate_gender!(gender_option)

      options.merge!(gender: GENDER_OPTIONS[gender_option]) if gender_option.is_a?(Symbol)

      post("/profile", options)
    end

    private

    def authenticated?
      !!@tinder_token
    end

    def validate_gender!(gender)
      return if gender.nil?
      return if (GENDER_OPTIONS.keys + GENDER_OPTIONS.values).include?(gender)

      raise "Invalid argument passed for gender (:male, :female, 0, 1) '#{gender}'"
    end

    def post(path, body)
      raise "Not authenticated!" unless authenticated?

      self.class.post(path, headers: headers, body: body.to_json).parsed_response
    end

    def headers
      {
        "content-type" => "application/json",
        "User-agent" => "Tinder/4.0.9 (iPhone; iOS 8.1.1; Scale/2.00)",
        "platform" => "ios",
      }.tap { |h| h["X-Auth-Token"] = @tinder_token if authenticated? }
    end
  end
end
