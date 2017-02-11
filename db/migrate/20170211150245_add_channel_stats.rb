class AddChannelStats < ActiveRecord::Migration[5.0]
  def change
    create_table :channel_stats do |t|
      t.datetime :updated_at
      t.integer  :followers
      t.integer  :views
    end
  end
end
