class AddStreamStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stream_stats do |t|
      t.integer  :views
    end

    create_table :stream_sessions do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.text     :game
      t.text     :title
    end
  end
end
