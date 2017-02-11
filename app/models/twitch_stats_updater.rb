require 'net/http'
require 'json'
require 'uri'

class TwitchStatsUpdater
  def self.update_channel_stats
    response = make_https_request("https://api.twitch.tv/kraken/channels/cumpp")

    ChannelStat.create(
      followers: response['followers'],
      updated_at: DateTime.now,
      views: response['views'],
    )
  end

  def self.update_stream_stats
    response = make_https_request("https://api.twitch.tv/kraken/streams/cumpp")

    StreamStat.create()
  end

  private

  def self.make_https_request(url)
    uri = URI.parse(url)
    header = { "Client-ID": ENV['TWITCH_CLIENT_ID'] }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri, header)

    response = http.request(request)
    return JSON.parse(response.body)
  end
end
