require "twitter"

$twitterClient = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_KEY"] # "YOUR_CONSUMER_KEY"
  config.consumer_secret     = ENV["TWITTER_SECRET_KEY"] # "YOUR_CONSUMER_SECRET"
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"] # "YOUR_ACCESS_TOKEN"
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"] # "YOUR_ACCESS_SECRET"
end

# ENV['TWITTER_KEY']
# ENV['TWITTER_SECRET_KEY']
# ENV['TWITTER_BEARER_TOKEN']
# ENV['TWITTER_ACCESS_TOKEN']
# ENV['TWITTER_ACCESS_TOKEN_SECRET']


