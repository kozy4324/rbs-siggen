require "test_helper"

# Tests for Article model
# Schema: create_table "articles", id: :string, force: :cascade
# The id column exists with the default name "id" but typed as String (not Integer).

class ArticleIdTest < ActiveSupport::TestCase # steep:ignore
  # @type const ORIGINAL_ID: String
  ORIGINAL_ID = "article-1"
  # @type const NEW_ID: String
  NEW_ID = "article-999"

  test "string id is typed as String" do
    article = Article.all.first!
    assert_instance_of String, article.id
  end

  test "string id= sets a new String value" do
    article = Article.all.first!
    article.id = NEW_ID
    assert_equal NEW_ID, article.id
  end

  test "string id_before_type_cast returns untyped" do
    article = Article.all.first!
    assert_equal ORIGINAL_ID, article.id_before_type_cast
  end

  test "string id_for_database returns untyped" do
    article = Article.all.first!
    assert_equal ORIGINAL_ID, article.id_for_database
  end

  test "string id_came_from_user? returns false for DB-loaded record" do
    article = Article.all.first!
    assert_equal false, article.id_came_from_user?
  end

  test "string id? returns bool" do
    article = Article.all.first!
    assert article.id?
  end

  test "string id_changed? returns false before change" do
    article = Article.all.first!
    assert_equal false, article.id_changed?
  end

  test "string id_changed? returns true after assignment" do
    article = Article.all.first!
    article.id = NEW_ID
    assert article.id_changed?
  end

  test "string id_change returns nil before change" do
    article = Article.all.first!
    assert_nil article.id_change
  end

  test "string id_change returns [old, new] after assignment" do
    article = Article.all.first!
    article.id = NEW_ID
    assert_equal [ORIGINAL_ID, NEW_ID], article.id_change
  end

  test "string id_will_change! marks attribute as changed" do
    article = Article.all.first!
    article.id_will_change!
    assert article.id_changed?
  end

  test "string id_was returns original value before change" do
    article = Article.all.first!
    assert_equal ORIGINAL_ID, article.id_was
  end

  test "string id_was returns old value after assignment" do
    article = Article.all.first!
    article.id = NEW_ID
    assert_equal ORIGINAL_ID, article.id_was
  end

  test "string restore_id! restores the original value" do
    article = Article.all.first!
    article.id = NEW_ID
    article.restore_id!
    assert_equal ORIGINAL_ID, article.id
    assert_equal false, article.id_changed?
  end

  test "string clear_id_change clears dirty state" do
    article = Article.all.first!
    article.id = NEW_ID
    article.clear_id_change
    assert_equal false, article.id_changed?
  end

  test "string will_save_change_to_id? returns false before change" do
    article = Article.all.first!
    assert_equal false, article.will_save_change_to_id?
  end

  test "string will_save_change_to_id? returns true after assignment" do
    article = Article.all.first!
    article.id = NEW_ID
    assert article.will_save_change_to_id?
  end

  test "string id_change_to_be_saved returns nil before change" do
    article = Article.all.first!
    assert_nil article.id_change_to_be_saved
  end

  test "string id_change_to_be_saved returns pending change after assignment" do
    article = Article.all.first!
    article.id = NEW_ID
    assert_equal [ORIGINAL_ID, NEW_ID], article.id_change_to_be_saved
  end

  test "string id_in_database returns the DB value" do
    article = Article.all.first!
    assert_equal ORIGINAL_ID, article.id_in_database
  end

  test "string id_previously_changed? returns true after save with change" do
    article = Article.all.first!
    article.id = NEW_ID
    article.save!
    assert article.id_previously_changed?
  end

  test "string id_previous_change returns [old, new] after save" do
    article = Article.all.first!
    article.id = NEW_ID
    article.save!
    assert_equal [ORIGINAL_ID, NEW_ID], article.id_previous_change
  end

  test "string id_previously_was returns old value after save" do
    article = Article.all.first!
    article.id = NEW_ID
    article.save!
    assert_equal ORIGINAL_ID, article.id_previously_was
  end

  test "string saved_change_to_id? returns false without save" do
    article = Article.all.first!
    assert_equal false, article.saved_change_to_id?
  end

  test "string saved_change_to_id? returns true after save with change" do
    article = Article.all.first!
    article.id = NEW_ID
    article.save!
    assert article.saved_change_to_id?
  end

  test "string saved_change_to_id returns nil without save" do
    article = Article.all.first!
    assert_nil article.saved_change_to_id
  end

  test "string saved_change_to_id returns [old, new] after save" do
    article = Article.all.first!
    article.id = NEW_ID
    article.save!
    assert_equal [ORIGINAL_ID, NEW_ID], article.saved_change_to_id
  end

  test "string id_before_last_save returns old value after save" do
    article = Article.all.first!
    article.id = NEW_ID
    article.save!
    assert_equal ORIGINAL_ID, article.id_before_last_save
  end
end
