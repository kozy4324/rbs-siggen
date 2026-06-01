class AddStartTimeToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :start_time, :time
  end
end
