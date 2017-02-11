class StreamStat < ActiveRecord::Base
  validates_presence_of :follows, :views
end
