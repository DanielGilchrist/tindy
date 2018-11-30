module Tindy
  class Client
    BASE_ENDPOINT = 'https://api.gotinder.com'.freeze

    def initialize(fb_token, fb_id)
      @token = authenticate(fb_token, fb_id)
    end

    def updates
      get('/updates')
    end

    def recommendations
      get('/recs')
    end

    private

    def authenticate(fb_token, fb_id)
      auth_obj = {
        facebook_token: fb_token,
        facebook_id: fb_id
      }.to_json

      res = with_retries { self.class.get(BASE_ENDPOINT + '/auth', query: auth_obj, headers: headers) }

      res.parsed_response
    end

    def get(path)
      res = with_retries { self.class.get(BASE_ENDPOINT + path, headers: headers) }
      res.parsed_response
    end

    def headers
      headers = {}

      headers['X-Auth-Token'] = @token if defined?(@token)
      headers['Content-type'] = 'application/json'
      headers['User-agent'] = 'User-Agent: Tinder/3.0.4 (iPhone; iOS 7.1; Scale/2.00)'

      headers
    end
  end
end
