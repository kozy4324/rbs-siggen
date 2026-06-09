require "test_helper"

# Tests for Account model
# Schema: create_table "accounts", primary_key: "account_code", id: :string, force: :cascade
# account_code is the custom-named primary key typed as String.
# id is generated as an alias for account_code (also String).

class AccountAccountCodeTest < ActiveSupport::TestCase # steep:ignore
  # @type const ORIGINAL_CODE: String
  ORIGINAL_CODE = "ACC-001"
  # @type const NEW_CODE: String
  NEW_CODE = "ACC-999"

  test "custom PK account_code is typed as String" do
    account = Account.all.first!
    assert_instance_of String, account.account_code
  end

  test "custom PK account_code= sets a new String value" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    assert_equal NEW_CODE, account.account_code
  end

  test "custom PK account_code_before_type_cast returns untyped" do
    account = Account.all.first!
    assert_equal ORIGINAL_CODE, account.account_code_before_type_cast
  end

  test "custom PK account_code_for_database returns untyped" do
    account = Account.all.first!
    assert_equal ORIGINAL_CODE, account.account_code_for_database
  end

  test "custom PK account_code_came_from_user? returns false for DB-loaded record" do
    account = Account.all.first!
    assert_equal false, account.account_code_came_from_user?
  end

  test "custom PK account_code? returns bool" do
    account = Account.all.first!
    assert account.account_code?
  end

  test "custom PK account_code_changed? returns false before change" do
    account = Account.all.first!
    assert_equal false, account.account_code_changed?
  end

  test "custom PK account_code_changed? returns true after assignment" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    assert account.account_code_changed?
  end

  test "custom PK account_code_change returns nil before change" do
    account = Account.all.first!
    assert_nil account.account_code_change
  end

  test "custom PK account_code_change returns [old, new] after assignment" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    assert_equal [ORIGINAL_CODE, NEW_CODE], account.account_code_change
  end

  test "custom PK account_code_will_change! marks attribute as changed" do
    account = Account.all.first!
    account.account_code_will_change!
    assert account.account_code_changed?
  end

  test "custom PK account_code_was returns original value before change" do
    account = Account.all.first!
    assert_equal ORIGINAL_CODE, account.account_code_was
  end

  test "custom PK account_code_was returns old value after assignment" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    assert_equal ORIGINAL_CODE, account.account_code_was
  end

  test "custom PK restore_account_code! restores the original value" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    account.restore_account_code!
    assert_equal ORIGINAL_CODE, account.account_code
    assert_equal false, account.account_code_changed?
  end

  test "custom PK clear_account_code_change clears dirty state" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    account.clear_account_code_change
    assert_equal false, account.account_code_changed?
  end

  test "custom PK will_save_change_to_account_code? returns false before change" do
    account = Account.all.first!
    assert_equal false, account.will_save_change_to_account_code?
  end

  test "custom PK will_save_change_to_account_code? returns true after assignment" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    assert account.will_save_change_to_account_code?
  end

  test "custom PK account_code_change_to_be_saved returns nil before change" do
    account = Account.all.first!
    assert_nil account.account_code_change_to_be_saved
  end

  test "custom PK account_code_change_to_be_saved returns pending change after assignment" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    assert_equal [ORIGINAL_CODE, NEW_CODE], account.account_code_change_to_be_saved
  end

  test "custom PK account_code_in_database returns the DB value" do
    account = Account.all.first!
    assert_equal ORIGINAL_CODE, account.account_code_in_database
  end

  test "custom PK account_code_previously_changed? returns true after save with change" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    account.save!
    assert account.account_code_previously_changed?
  end

  test "custom PK account_code_previous_change returns [old, new] after save" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    account.save!
    assert_equal [ORIGINAL_CODE, NEW_CODE], account.account_code_previous_change
  end

  test "custom PK account_code_previously_was returns old value after save" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    account.save!
    assert_equal ORIGINAL_CODE, account.account_code_previously_was
  end

  test "custom PK saved_change_to_account_code? returns false without save" do
    account = Account.all.first!
    assert_equal false, account.saved_change_to_account_code?
  end

  test "custom PK saved_change_to_account_code? returns true after save with change" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    account.save!
    assert account.saved_change_to_account_code?
  end

  test "custom PK saved_change_to_account_code returns nil without save" do
    account = Account.all.first!
    assert_nil account.saved_change_to_account_code
  end

  test "custom PK saved_change_to_account_code returns [old, new] after save" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    account.save!
    assert_equal [ORIGINAL_CODE, NEW_CODE], account.saved_change_to_account_code
  end

  test "custom PK account_code_before_last_save returns old value after save" do
    account = Account.all.first!
    account.account_code = NEW_CODE
    account.save!
    assert_equal ORIGINAL_CODE, account.account_code_before_last_save
  end
end

class AccountIdAliasTest < ActiveSupport::TestCase # steep:ignore
  test "id is typed as String (alias for custom PK account_code)" do
    account = Account.all.first!
    assert_instance_of String, account.id
  end

  test "id returns the same value as account_code" do
    account = Account.all.first!
    assert_equal account.account_code, account.id
  end

  test "id= propagates to account_code" do
    account = Account.all.first!
    account.id = "ACC-999"
    assert_equal "ACC-999", account.account_code
    assert_equal "ACC-999", account.id
  end
end
