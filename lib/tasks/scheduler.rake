desc "This task is called by the Heroku scheduler add-on"

task :update_channel_stats => :environment do
  puts "Updating channel stats..."
  TwitchStatsUpdater.update_channel_stats
  puts "done."
end

task :update_stream_stats => :environment do
  puts "Updating stream stats..."
  TwitchStatsUpdater.update_stream_stats
  puts "done."
end
