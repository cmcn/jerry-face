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
    last_session = StreamSession.last
    response = make_https_request("https://api.twitch.tv/kraken/streams/cumpp")
    stream_data = response['stream']
    channel_data = response['channel']

    if stream_data
      if !last_session || last_session.end_time
        StreamSession.create(
          start_time: stream_data['created_at'],
          game: stream_data['game'],
          title: channel_data['status']
        )
      elsif last_session.game != stream_data['game']
        last_session.update(end_time: stream_data['created_at'])

        StreamSession.create(
          start_time: stream_data['created_at'],
          game: stream_data['game'],
          title: channel_data['status']
        )
      end

      ChannelStat.create(
        followers: channel_data['followers'],
        updated_at: DateTime.now,
        views: channel_data['views']
      )
    else
      last_session.update(end_time: DateTime.now) if last_session
    end
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
