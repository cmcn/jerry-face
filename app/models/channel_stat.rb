class ChannelStat < ActiveRecord::Base
  validates_presence_of :followers, :updated_at, :views
end
