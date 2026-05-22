require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "the truth" do
    post = Post.first!
    assert_equal "MyString", post.title
  end

  test "bigint column views_count is typed as Integer" do
    post = Post.first!
    assert_equal 1_000_000, post.views_count
  end

  test "bigint column views_count= sets a new Integer value" do
    post = Post.first!
    post.views_count = 2_000_000
    assert_equal 2_000_000, post.views_count
  end

  test "bigint column views_count_before_type_cast returns untyped" do
    post = Post.first!
    assert_equal 1_000_000, post.views_count_before_type_cast
  end

  test "bigint column views_count_for_database returns untyped" do
    post = Post.first!
    assert_equal 1_000_000, post.views_count_for_database
  end

  test "bigint column views_count_came_from_user? returns false for DB-loaded record" do
    post = Post.first!
    assert_equal false, post.views_count_came_from_user?
  end

  test "bigint column views_count? returns true for non-zero value" do
    post = Post.first!
    assert post.views_count?
  end

  test "bigint column views_count_changed? returns false before change" do
    post = Post.first!
    assert_equal false, post.views_count_changed?
  end

  test "bigint column views_count_changed? returns true after assignment" do
    post = Post.first!
    post.views_count = 2_000_000
    assert post.views_count_changed?
  end

  test "bigint column views_count_change returns nil before change" do
    post = Post.first!
    assert_nil post.views_count_change
  end

  test "bigint column views_count_change returns [old, new] after assignment" do
    post = Post.first!
    post.views_count = 2_000_000
    assert_equal [1_000_000, 2_000_000], post.views_count_change
  end

  test "bigint column views_count_will_change! marks attribute as changed" do
    post = Post.first!
    post.views_count_will_change!
    assert post.views_count_changed?
  end

  test "bigint column views_count_was returns original value before change" do
    post = Post.first!
    assert_equal 1_000_000, post.views_count_was
  end

  test "bigint column views_count_was returns old value after assignment" do
    post = Post.first!
    post.views_count = 2_000_000
    assert_equal 1_000_000, post.views_count_was
  end

  test "bigint column restore_views_count! restores the original value" do
    post = Post.first!
    post.views_count = 2_000_000
    post.restore_views_count!
    assert_equal 1_000_000, post.views_count
    assert_equal false, post.views_count_changed?
  end

  test "bigint column clear_views_count_change clears dirty state" do
    post = Post.first!
    post.views_count = 2_000_000
    post.clear_views_count_change
    assert_equal false, post.views_count_changed?
  end

  test "bigint column will_save_change_to_views_count? returns false before change" do
    post = Post.first!
    assert_equal false, post.will_save_change_to_views_count?
  end

  test "bigint column will_save_change_to_views_count? returns true after assignment" do
    post = Post.first!
    post.views_count = 2_000_000
    assert post.will_save_change_to_views_count?
  end

  test "bigint column views_count_change_to_be_saved returns nil before change" do
    post = Post.first!
    assert_nil post.views_count_change_to_be_saved
  end

  test "bigint column views_count_change_to_be_saved returns pending change after assignment" do
    post = Post.first!
    post.views_count = 2_000_000
    assert_equal [1_000_000, 2_000_000], post.views_count_change_to_be_saved
  end

  test "bigint column views_count_in_database returns the DB value" do
    post = Post.first!
    assert_equal 1_000_000, post.views_count_in_database
  end

  test "bigint column views_count_previously_changed? returns true after save with change" do
    post = Post.first!
    post.views_count = 2_000_000
    post.save!
    assert post.views_count_previously_changed?
  end

  test "bigint column views_count_previous_change returns [old, new] after save" do
    post = Post.first!
    post.views_count = 2_000_000
    post.save!
    assert_equal [1_000_000, 2_000_000], post.views_count_previous_change
  end

  test "bigint column views_count_previously_was returns old value after save" do
    post = Post.first!
    post.views_count = 2_000_000
    post.save!
    assert_equal 1_000_000, post.views_count_previously_was
  end

  test "bigint column saved_change_to_views_count? returns false without save" do
    post = Post.first!
    assert_equal false, post.saved_change_to_views_count?
  end

  test "bigint column saved_change_to_views_count? returns true after save with change" do
    post = Post.first!
    post.views_count = 2_000_000
    post.save!
    assert post.saved_change_to_views_count?
  end

  test "bigint column saved_change_to_views_count returns nil without save" do
    post = Post.first!
    assert_nil post.saved_change_to_views_count
  end

  test "bigint column saved_change_to_views_count returns [old, new] after save" do
    post = Post.first!
    post.views_count = 2_000_000
    post.save!
    assert_equal [1_000_000, 2_000_000], post.saved_change_to_views_count
  end

  test "bigint column views_count_before_last_save returns old value after save" do
    post = Post.first!
    post.views_count = 2_000_000
    post.save!
    assert_equal 1_000_000, post.views_count_before_last_save
  end
end
