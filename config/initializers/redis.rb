ENV["REDISTOGO_URL"] = "redis://redis:6379" if Rails.env.development? || Rails.env.test?

if ENV["REDISTOGO_URL"]
  uri = URI.parse(ENV["REDISTOGO_URL"])
  REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)
end
