require "test_helper"

# Tests for PostTag model
# Schema: create_table "post_tags", id: false, force: :cascade
# No id column is generated. The RBS has no def id in GeneratedAttributeMethods.
# Columns: post_id (Integer, NOT NULL), tag_name (String, NOT NULL)

# PostTagIdFalseTest: id: false means no def id appears in the generated RBS.
# The absence of id method is verified at the RBS level (Steep would reject post_tag.id).
class PostTagIdFalseTest < ActiveSupport::TestCase
  test "id: false model loads without a primary key column" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert_instance_of PostTag, post_tag
  end
end

class PostTagPostIdTest < ActiveSupport::TestCase
  test "post_id is typed as Integer" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert_instance_of Integer, post_tag.post_id
  end

  test "post_id= sets a new Integer value" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    post_tag.post_id = 2
    assert_equal 2, post_tag.post_id
  end

  test "post_id_before_type_cast returns untyped" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert_equal 1, post_tag.post_id_before_type_cast
  end

  test "post_id_for_database returns untyped" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert_equal 1, post_tag.post_id_for_database
  end

  test "post_id_came_from_user? returns false for DB-loaded record" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert_equal false, post_tag.post_id_came_from_user?
  end

  test "post_id? returns bool" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert post_tag.post_id?
  end

  test "post_id_changed? returns false before change" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert_equal false, post_tag.post_id_changed?
  end

  test "post_id_changed? returns true after assignment" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    post_tag.post_id = 2
    assert post_tag.post_id_changed?
  end

  test "post_id_change returns nil before change" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert_nil post_tag.post_id_change
  end

  test "post_id_change returns [old, new] after assignment" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    post_tag.post_id = 2
    assert_equal [1, 2], post_tag.post_id_change
  end

  test "post_id_will_change! marks attribute as changed" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    post_tag.post_id_will_change!
    assert post_tag.post_id_changed?
  end

  test "post_id_was returns original value before change" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert_equal 1, post_tag.post_id_was
  end

  test "post_id_was returns old value after assignment" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    post_tag.post_id = 2
    assert_equal 1, post_tag.post_id_was
  end

  test "restore_post_id! restores the original value" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    post_tag.post_id = 2
    post_tag.restore_post_id!
    assert_equal 1, post_tag.post_id
    assert_equal false, post_tag.post_id_changed?
  end

  test "clear_post_id_change clears dirty state" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    post_tag.post_id = 2
    post_tag.clear_post_id_change
    assert_equal false, post_tag.post_id_changed?
  end

  test "will_save_change_to_post_id? returns false before change" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert_equal false, post_tag.will_save_change_to_post_id?
  end

  test "will_save_change_to_post_id? returns true after assignment" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    post_tag.post_id = 2
    assert post_tag.will_save_change_to_post_id?
  end

  test "post_id_change_to_be_saved returns nil before change" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert_nil post_tag.post_id_change_to_be_saved
  end

  test "post_id_change_to_be_saved returns pending change after assignment" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    post_tag.post_id = 2
    assert_equal [1, 2], post_tag.post_id_change_to_be_saved
  end

  test "post_id_in_database returns the DB value" do
    post_tag = PostTag.find_by!(tag_name: "rails")
    assert_equal 1, post_tag.post_id_in_database
  end
end

class PostTagTagNameTest < ActiveSupport::TestCase
  ORIGINAL_TAG_NAME = "rails"
  NEW_TAG_NAME = "crystal"

  test "tag_name is typed as String" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    assert_instance_of String, post_tag.tag_name
  end

  test "tag_name= sets a new String value" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    post_tag.tag_name = NEW_TAG_NAME
    assert_equal NEW_TAG_NAME, post_tag.tag_name
  end

  test "tag_name_before_type_cast returns untyped" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    assert_equal ORIGINAL_TAG_NAME, post_tag.tag_name_before_type_cast
  end

  test "tag_name_for_database returns untyped" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    assert_equal ORIGINAL_TAG_NAME, post_tag.tag_name_for_database
  end

  test "tag_name_came_from_user? returns false for DB-loaded record" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    assert_equal false, post_tag.tag_name_came_from_user?
  end

  test "tag_name? returns bool" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    assert post_tag.tag_name?
  end

  test "tag_name_changed? returns false before change" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    assert_equal false, post_tag.tag_name_changed?
  end

  test "tag_name_changed? returns true after assignment" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    post_tag.tag_name = NEW_TAG_NAME
    assert post_tag.tag_name_changed?
  end

  test "tag_name_change returns nil before change" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    assert_nil post_tag.tag_name_change
  end

  test "tag_name_change returns [old, new] after assignment" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    post_tag.tag_name = NEW_TAG_NAME
    assert_equal [ORIGINAL_TAG_NAME, NEW_TAG_NAME], post_tag.tag_name_change
  end

  test "tag_name_will_change! marks attribute as changed" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    post_tag.tag_name_will_change!
    assert post_tag.tag_name_changed?
  end

  test "tag_name_was returns original value before change" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    assert_equal ORIGINAL_TAG_NAME, post_tag.tag_name_was
  end

  test "tag_name_was returns old value after assignment" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    post_tag.tag_name = NEW_TAG_NAME
    assert_equal ORIGINAL_TAG_NAME, post_tag.tag_name_was
  end

  test "restore_tag_name! restores the original value" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    post_tag.tag_name = NEW_TAG_NAME
    post_tag.restore_tag_name!
    assert_equal ORIGINAL_TAG_NAME, post_tag.tag_name
    assert_equal false, post_tag.tag_name_changed?
  end

  test "clear_tag_name_change clears dirty state" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    post_tag.tag_name = NEW_TAG_NAME
    post_tag.clear_tag_name_change
    assert_equal false, post_tag.tag_name_changed?
  end

  test "will_save_change_to_tag_name? returns false before change" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    assert_equal false, post_tag.will_save_change_to_tag_name?
  end

  test "will_save_change_to_tag_name? returns true after assignment" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    post_tag.tag_name = NEW_TAG_NAME
    assert post_tag.will_save_change_to_tag_name?
  end

  test "tag_name_change_to_be_saved returns nil before change" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    assert_nil post_tag.tag_name_change_to_be_saved
  end

  test "tag_name_change_to_be_saved returns pending change after assignment" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    post_tag.tag_name = NEW_TAG_NAME
    assert_equal [ORIGINAL_TAG_NAME, NEW_TAG_NAME], post_tag.tag_name_change_to_be_saved
  end

  test "tag_name_in_database returns the DB value" do
    post_tag = PostTag.find_by!(tag_name: ORIGINAL_TAG_NAME)
    assert_equal ORIGINAL_TAG_NAME, post_tag.tag_name_in_database
  end
end
