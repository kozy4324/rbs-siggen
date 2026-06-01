class AddPublishedOnToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :published_on, :date
  end
end
