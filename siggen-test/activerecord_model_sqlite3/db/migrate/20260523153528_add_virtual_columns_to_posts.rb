class AddVirtualColumnsToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :slug, :virtual, type: :string, as: "lower(title)", stored: true
    add_column :posts, :engagement_count, :virtual, type: :integer, as: "likes_count + views_count", stored: true
  end
end
