require "test_helper"

# Tests for Tagging model
# Schema: create_table "taggings", primary_key: ["post_id", "tag_id"], force: :cascade
# Model:  self.primary_key = [:post_id, :tag_id]
# The composite primary key means id returns Array[untyped]? (e.g. [1, 1]).

class TaggingIdTest < ActiveSupport::TestCase # steep:ignore
  test "composite PK id is typed as Array" do
    tagging = Tagging.all.first!
    assert_instance_of Array, tagging.id
  end

  test "composite PK id returns [post_id, tag_id]" do
    tagging = Tagging.all.first!
    assert_equal [tagging.post_id, tagging.tag_id], tagging.id
  end

  test "composite PK id? returns bool" do
    tagging = Tagging.all.first!
    assert tagging.id?
  end

  # With composite PKs, id_changed? tracks the virtual id attribute directly,
  # not constituent column changes. Changing a constituent column (tag_id)
  # does NOT flip id_changed? — use tag_id_changed? instead.
  test "composite PK id_changed? returns false before change" do
    tagging = Tagging.all.first!
    assert_equal false, tagging.id_changed?
  end

  test "composite PK id_changed? remains false even after constituent column change" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    assert_equal false, tagging.id_changed?
  end

  # id_change returns nil because id has no direct attribute tracking.
  test "composite PK id_change returns nil before change" do
    tagging = Tagging.all.first!
    assert_nil tagging.id_change
  end

  test "composite PK id_change returns nil even after constituent column change" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    assert_nil tagging.id_change
  end

  # id_was reflects the original composite key via constituent _was values.
  test "composite PK id_was returns the original composite key after constituent change" do
    tagging = Tagging.all.first!
    original = tagging.id.dup
    tagging.tag_id = 99
    assert_equal original, tagging.id_was
  end

  test "composite PK id_in_database returns the DB value" do
    tagging = Tagging.all.first!
    assert_equal [1, 1], tagging.id_in_database
  end

  test "composite PK will_save_change_to_id? returns false" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    assert_equal false, tagging.will_save_change_to_id?
  end

  test "composite PK id_change_to_be_saved returns nil" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    assert_nil tagging.id_change_to_be_saved
  end
end

class TaggingPostIdTest < ActiveSupport::TestCase # steep:ignore
  test "post_id is typed as Integer" do
    tagging = Tagging.all.first!
    assert_instance_of Integer, tagging.post_id
  end

  test "post_id= sets a new Integer value" do
    tagging = Tagging.all.first!
    tagging.post_id = 2
    assert_equal 2, tagging.post_id
  end

  test "post_id_before_type_cast returns untyped" do
    tagging = Tagging.all.first!
    assert_equal 1, tagging.post_id_before_type_cast
  end

  test "post_id_for_database returns untyped" do
    tagging = Tagging.all.first!
    assert_equal 1, tagging.post_id_for_database
  end

  test "post_id_came_from_user? returns false for DB-loaded record" do
    tagging = Tagging.all.first!
    assert_equal false, tagging.post_id_came_from_user?
  end

  test "post_id? returns bool" do
    tagging = Tagging.all.first!
    assert tagging.post_id?
  end

  test "post_id_changed? returns false before change" do
    tagging = Tagging.all.first!
    assert_equal false, tagging.post_id_changed?
  end

  test "post_id_changed? returns true after assignment" do
    tagging = Tagging.all.first!
    tagging.post_id = 2
    assert tagging.post_id_changed?
  end

  test "post_id_change returns nil before change" do
    tagging = Tagging.all.first!
    assert_nil tagging.post_id_change
  end

  test "post_id_change returns [old, new] after assignment" do
    tagging = Tagging.all.first!
    tagging.post_id = 2
    assert_equal [1, 2], tagging.post_id_change
  end

  test "post_id_will_change! marks attribute as changed" do
    tagging = Tagging.all.first!
    tagging.post_id_will_change!
    assert tagging.post_id_changed?
  end

  test "post_id_was returns original value before change" do
    tagging = Tagging.all.first!
    assert_equal 1, tagging.post_id_was
  end

  test "post_id_was returns old value after assignment" do
    tagging = Tagging.all.first!
    tagging.post_id = 2
    assert_equal 1, tagging.post_id_was
  end

  test "restore_post_id! restores the original value" do
    tagging = Tagging.all.first!
    tagging.post_id = 2
    tagging.restore_post_id!
    assert_equal 1, tagging.post_id
    assert_equal false, tagging.post_id_changed?
  end

  test "clear_post_id_change clears dirty state" do
    tagging = Tagging.all.first!
    tagging.post_id = 2
    tagging.clear_post_id_change
    assert_equal false, tagging.post_id_changed?
  end

  test "will_save_change_to_post_id? returns false before change" do
    tagging = Tagging.all.first!
    assert_equal false, tagging.will_save_change_to_post_id?
  end

  test "will_save_change_to_post_id? returns true after assignment" do
    tagging = Tagging.all.first!
    tagging.post_id = 2
    assert tagging.will_save_change_to_post_id?
  end

  test "post_id_change_to_be_saved returns nil before change" do
    tagging = Tagging.all.first!
    assert_nil tagging.post_id_change_to_be_saved
  end

  test "post_id_change_to_be_saved returns pending change after assignment" do
    tagging = Tagging.all.first!
    tagging.post_id = 2
    assert_equal [1, 2], tagging.post_id_change_to_be_saved
  end

  test "post_id_in_database returns the DB value" do
    tagging = Tagging.all.first!
    assert_equal 1, tagging.post_id_in_database
  end
end

class TaggingTagIdTest < ActiveSupport::TestCase # steep:ignore
  test "tag_id is typed as Integer" do
    tagging = Tagging.all.first!
    assert_instance_of Integer, tagging.tag_id
  end

  test "tag_id= sets a new Integer value" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    assert_equal 99, tagging.tag_id
  end

  test "tag_id_before_type_cast returns untyped" do
    tagging = Tagging.all.first!
    assert_equal 1, tagging.tag_id_before_type_cast
  end

  test "tag_id_for_database returns untyped" do
    tagging = Tagging.all.first!
    assert_equal 1, tagging.tag_id_for_database
  end

  test "tag_id_came_from_user? returns false for DB-loaded record" do
    tagging = Tagging.all.first!
    assert_equal false, tagging.tag_id_came_from_user?
  end

  test "tag_id? returns bool" do
    tagging = Tagging.all.first!
    assert tagging.tag_id?
  end

  test "tag_id_changed? returns false before change" do
    tagging = Tagging.all.first!
    assert_equal false, tagging.tag_id_changed?
  end

  test "tag_id_changed? returns true after assignment" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    assert tagging.tag_id_changed?
  end

  test "tag_id_change returns nil before change" do
    tagging = Tagging.all.first!
    assert_nil tagging.tag_id_change
  end

  test "tag_id_change returns [old, new] after assignment" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    assert_equal [1, 99], tagging.tag_id_change
  end

  test "tag_id_will_change! marks attribute as changed" do
    tagging = Tagging.all.first!
    tagging.tag_id_will_change!
    assert tagging.tag_id_changed?
  end

  test "tag_id_was returns original value before change" do
    tagging = Tagging.all.first!
    assert_equal 1, tagging.tag_id_was
  end

  test "tag_id_was returns old value after assignment" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    assert_equal 1, tagging.tag_id_was
  end

  test "restore_tag_id! restores the original value" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    tagging.restore_tag_id!
    assert_equal 1, tagging.tag_id
    assert_equal false, tagging.tag_id_changed?
  end

  test "clear_tag_id_change clears dirty state" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    tagging.clear_tag_id_change
    assert_equal false, tagging.tag_id_changed?
  end

  test "will_save_change_to_tag_id? returns false before change" do
    tagging = Tagging.all.first!
    assert_equal false, tagging.will_save_change_to_tag_id?
  end

  test "will_save_change_to_tag_id? returns true after assignment" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    assert tagging.will_save_change_to_tag_id?
  end

  test "tag_id_change_to_be_saved returns nil before change" do
    tagging = Tagging.all.first!
    assert_nil tagging.tag_id_change_to_be_saved
  end

  test "tag_id_change_to_be_saved returns pending change after assignment" do
    tagging = Tagging.all.first!
    tagging.tag_id = 99
    assert_equal [1, 99], tagging.tag_id_change_to_be_saved
  end

  test "tag_id_in_database returns the DB value" do
    tagging = Tagging.all.first!
    assert_equal 1, tagging.tag_id_in_database
  end
end
