class CreateTaggings < ActiveRecord::Migration[8.1]
  def change
    create_table "taggings", primary_key: [:post_id, :tag_id] do |t|
      t.integer "post_id", null: false
      t.integer "tag_id", null: false
      t.string "context"
    end
  end
end
