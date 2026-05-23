class CreateAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table "accounts", id: :string, primary_key: "account_code" do |t|
      t.string "name"
    end
  end
end
