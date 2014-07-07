# Rack::HaproxyStatus

HAproxy can automatically drop members out of a balancer pool if they return a 50x status code. This tiny mountable Rack app facilitates this.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-haproxy_status'

And then execute:

    $ bundle

## Usage

If you're using Rails, you can add this line to your `config/routes.rb`:

    mount Rack::HaproxyStatus::Endpoint.new(path: Rails.root.join('config/balancer_state')) => "/load_balancer_status"

Then make sure that `config/balancer_state` contains either `on` or `off`. Anything else will raise an exception. In your HAproxy config, add this line under the backend:

    option httpchk HEAD /load_balancer_status HTTP/1.1

Or a slightly more advanced example where you set some additional headers:

    option httpchk HEAD /load_balancer_status HTTP/1.1\r\nHost:\ www.myhost.com\r\nX-Forwarded-Proto:\ https

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rack-haproxy_status/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
