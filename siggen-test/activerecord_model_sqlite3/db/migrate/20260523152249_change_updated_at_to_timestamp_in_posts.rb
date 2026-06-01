class ChangeUpdatedAtToTimestampInPosts < ActiveRecord::Migration[8.1]
  def change
    change_column :posts, :updated_at, :timestamp, null: false
  end
end
