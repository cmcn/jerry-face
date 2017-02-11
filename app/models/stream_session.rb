class StreamSession < ActiveRecord::Base
  validates_presence_of :game, :start_time, :title
end
