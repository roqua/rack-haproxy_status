require "rack/haproxy_status/version"

module Rack
  module HaproxyStatus
    class Endpoint
      InvalidStatus = Class.new(StandardError)

      VALID_STATES = %w(on off)

      def initialize(path:, io: ::File)
        @path = path
        @io = io
      end

      def call(env)
        if balancer_member?
          [200, {'Content-Type' => 'application/json'}, ['{"status": "ok", "member": true}']]
        else
          [503, {'Content-Type' => 'application/json'}, ['{"status": "ok", "member": false}']]
        end
      rescue InvalidStatus
        [500, {'Content-Type' => 'application/json'}, ['{"status": "unknown status"}']]
      end

      private

      def balancer_member?
        state = @io.read(@path).strip
        raise InvalidStatus, "Invalid state: #{state}" unless VALID_STATES.include?(state)
        state == "on"
      end
    end
  end
end
