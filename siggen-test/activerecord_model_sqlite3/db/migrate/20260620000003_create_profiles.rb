class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.references :author, null: false, foreign_key: true
      t.string :avatar_url
      t.text :bio
      t.string :website_url
      t.timestamps
    end
  end
end
