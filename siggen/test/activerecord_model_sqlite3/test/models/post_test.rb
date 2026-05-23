require "test_helper"

class PostViewsCountTest < ActiveSupport::TestCase
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

class PostBodyTest < ActiveSupport::TestCase
  test "text column body is typed as String" do
    post = Post.first!
    assert_equal "MyText", post.body
  end

  test "text column body= sets a new String value" do
    post = Post.first!
    post.body = "NewText"
    assert_equal "NewText", post.body
  end

  test "text column body_before_type_cast returns untyped" do
    post = Post.first!
    assert_equal "MyText", post.body_before_type_cast
  end

  test "text column body_for_database returns untyped" do
    post = Post.first!
    assert_equal "MyText", post.body_for_database
  end

  test "text column body_came_from_user? returns false for DB-loaded record" do
    post = Post.first!
    assert_equal false, post.body_came_from_user?
  end

  test "text column body? returns bool" do
    post = Post.first!
    assert post.body?
  end

  test "text column body_changed? returns false before change" do
    post = Post.first!
    assert_equal false, post.body_changed?
  end

  test "text column body_changed? returns true after assignment" do
    post = Post.first!
    post.body = "NewText"
    assert post.body_changed?
  end

  test "text column body_change returns nil before change" do
    post = Post.first!
    assert_nil post.body_change
  end

  test "text column body_change returns [old, new] after assignment" do
    post = Post.first!
    post.body = "NewText"
    assert_equal ["MyText", "NewText"], post.body_change
  end

  test "text column body_will_change! marks attribute as changed" do
    post = Post.first!
    post.body_will_change!
    assert post.body_changed?
  end

  test "text column body_was returns original value before change" do
    post = Post.first!
    assert_equal "MyText", post.body_was
  end

  test "text column body_was returns old value after assignment" do
    post = Post.first!
    post.body = "NewText"
    assert_equal "MyText", post.body_was
  end

  test "text column restore_body! restores the original value" do
    post = Post.first!
    post.body = "NewText"
    post.restore_body!
    assert_equal "MyText", post.body
    assert_equal false, post.body_changed?
  end

  test "text column clear_body_change clears dirty state" do
    post = Post.first!
    post.body = "NewText"
    post.clear_body_change
    assert_equal false, post.body_changed?
  end

  test "text column will_save_change_to_body? returns false before change" do
    post = Post.first!
    assert_equal false, post.will_save_change_to_body?
  end

  test "text column will_save_change_to_body? returns true after assignment" do
    post = Post.first!
    post.body = "NewText"
    assert post.will_save_change_to_body?
  end

  test "text column body_change_to_be_saved returns nil before change" do
    post = Post.first!
    assert_nil post.body_change_to_be_saved
  end

  test "text column body_change_to_be_saved returns pending change after assignment" do
    post = Post.first!
    post.body = "NewText"
    assert_equal ["MyText", "NewText"], post.body_change_to_be_saved
  end

  test "text column body_in_database returns the DB value" do
    post = Post.first!
    assert_equal "MyText", post.body_in_database
  end

  test "text column body_previously_changed? returns true after save with change" do
    post = Post.first!
    post.body = "NewText"
    post.save!
    assert post.body_previously_changed?
  end

  test "text column body_previous_change returns [old, new] after save" do
    post = Post.first!
    post.body = "NewText"
    post.save!
    assert_equal ["MyText", "NewText"], post.body_previous_change
  end

  test "text column body_previously_was returns old value after save" do
    post = Post.first!
    post.body = "NewText"
    post.save!
    assert_equal "MyText", post.body_previously_was
  end

  test "text column saved_change_to_body? returns false without save" do
    post = Post.first!
    assert_equal false, post.saved_change_to_body?
  end

  test "text column saved_change_to_body? returns true after save with change" do
    post = Post.first!
    post.body = "NewText"
    post.save!
    assert post.saved_change_to_body?
  end

  test "text column saved_change_to_body returns nil without save" do
    post = Post.first!
    assert_nil post.saved_change_to_body
  end

  test "text column saved_change_to_body returns [old, new] after save" do
    post = Post.first!
    post.body = "NewText"
    post.save!
    assert_equal ["MyText", "NewText"], post.saved_change_to_body
  end

  test "text column body_before_last_save returns old value after save" do
    post = Post.first!
    post.body = "NewText"
    post.save!
    assert_equal "MyText", post.body_before_last_save
  end
end

class PostTitleTest < ActiveSupport::TestCase
  test "string column title is typed as String" do
    post = Post.first!
    assert_equal "MyString", post.title
  end

  test "string column title= sets a new String value" do
    post = Post.first!
    post.title = "NewString"
    assert_equal "NewString", post.title
  end

  test "string column title_before_type_cast returns untyped" do
    post = Post.first!
    assert_equal "MyString", post.title_before_type_cast
  end

  test "string column title_for_database returns untyped" do
    post = Post.first!
    assert_equal "MyString", post.title_for_database
  end

  test "string column title_came_from_user? returns false for DB-loaded record" do
    post = Post.first!
    assert_equal false, post.title_came_from_user?
  end

  test "string column title? returns bool" do
    post = Post.first!
    assert post.title?
  end

  test "string column title_changed? returns false before change" do
    post = Post.first!
    assert_equal false, post.title_changed?
  end

  test "string column title_changed? returns true after assignment" do
    post = Post.first!
    post.title = "NewString"
    assert post.title_changed?
  end

  test "string column title_change returns nil before change" do
    post = Post.first!
    assert_nil post.title_change
  end

  test "string column title_change returns [old, new] after assignment" do
    post = Post.first!
    post.title = "NewString"
    assert_equal ["MyString", "NewString"], post.title_change
  end

  test "string column title_will_change! marks attribute as changed" do
    post = Post.first!
    post.title_will_change!
    assert post.title_changed?
  end

  test "string column title_was returns original value before change" do
    post = Post.first!
    assert_equal "MyString", post.title_was
  end

  test "string column title_was returns old value after assignment" do
    post = Post.first!
    post.title = "NewString"
    assert_equal "MyString", post.title_was
  end

  test "string column restore_title! restores the original value" do
    post = Post.first!
    post.title = "NewString"
    post.restore_title!
    assert_equal "MyString", post.title
    assert_equal false, post.title_changed?
  end

  test "string column clear_title_change clears dirty state" do
    post = Post.first!
    post.title = "NewString"
    post.clear_title_change
    assert_equal false, post.title_changed?
  end

  test "string column will_save_change_to_title? returns false before change" do
    post = Post.first!
    assert_equal false, post.will_save_change_to_title?
  end

  test "string column will_save_change_to_title? returns true after assignment" do
    post = Post.first!
    post.title = "NewString"
    assert post.will_save_change_to_title?
  end

  test "string column title_change_to_be_saved returns nil before change" do
    post = Post.first!
    assert_nil post.title_change_to_be_saved
  end

  test "string column title_change_to_be_saved returns pending change after assignment" do
    post = Post.first!
    post.title = "NewString"
    assert_equal ["MyString", "NewString"], post.title_change_to_be_saved
  end

  test "string column title_in_database returns the DB value" do
    post = Post.first!
    assert_equal "MyString", post.title_in_database
  end

  test "string column title_previously_changed? returns true after save with change" do
    post = Post.first!
    post.title = "NewString"
    post.save!
    assert post.title_previously_changed?
  end

  test "string column title_previous_change returns [old, new] after save" do
    post = Post.first!
    post.title = "NewString"
    post.save!
    assert_equal ["MyString", "NewString"], post.title_previous_change
  end

  test "string column title_previously_was returns old value after save" do
    post = Post.first!
    post.title = "NewString"
    post.save!
    assert_equal "MyString", post.title_previously_was
  end

  test "string column saved_change_to_title? returns false without save" do
    post = Post.first!
    assert_equal false, post.saved_change_to_title?
  end

  test "string column saved_change_to_title? returns true after save with change" do
    post = Post.first!
    post.title = "NewString"
    post.save!
    assert post.saved_change_to_title?
  end

  test "string column saved_change_to_title returns nil without save" do
    post = Post.first!
    assert_nil post.saved_change_to_title
  end

  test "string column saved_change_to_title returns [old, new] after save" do
    post = Post.first!
    post.title = "NewString"
    post.save!
    assert_equal ["MyString", "NewString"], post.saved_change_to_title
  end

  test "string column title_before_last_save returns old value after save" do
    post = Post.first!
    post.title = "NewString"
    post.save!
    assert_equal "MyString", post.title_before_last_save
  end
end

class PostThumbnailTest < ActiveSupport::TestCase
  # --- getter / setter ---

  test "binary column thumbnail is typed as String" do
    post = Post.first!
    assert_equal "hello", post.thumbnail
  end

  test "binary column thumbnail= sets a new String value" do
    post = Post.first!
    post.thumbnail = "world"
    assert_equal "world", post.thumbnail
  end

  # --- BeforeTypeCast / ForDatabase ---

  test "binary column thumbnail_before_type_cast returns untyped" do
    post = Post.first!
    assert_equal "hello", post.thumbnail_before_type_cast
  end

  test "binary column thumbnail_for_database returns untyped" do
    post = Post.first!
    assert_equal "hello", post.thumbnail_for_database
  end

  # --- came_from_user? / query method ---

  test "binary column thumbnail_came_from_user? returns false for DB-loaded record" do
    post = Post.first!
    assert_equal false, post.thumbnail_came_from_user?
  end

  test "binary column thumbnail? returns bool" do
    post = Post.first!
    assert post.thumbnail?
  end

  # --- Dirty tracking: in-memory change ---

  test "binary column thumbnail_changed? returns false before change" do
    post = Post.first!
    assert_equal false, post.thumbnail_changed?
  end

  test "binary column thumbnail_changed? returns true after assignment" do
    post = Post.first!
    post.thumbnail = "world"
    assert post.thumbnail_changed?
  end

  test "binary column thumbnail_change returns nil before change" do
    post = Post.first!
    assert_nil post.thumbnail_change
  end

  test "binary column thumbnail_change returns [old, new] after assignment" do
    post = Post.first!
    post.thumbnail = "world"
    assert_equal ["hello", "world"], post.thumbnail_change
  end

  test "binary column thumbnail_will_change! marks attribute as changed" do
    post = Post.first!
    post.thumbnail_will_change!
    assert post.thumbnail_changed?
  end

  test "binary column thumbnail_was returns original value before change" do
    post = Post.first!
    assert_equal "hello", post.thumbnail_was
  end

  test "binary column thumbnail_was returns old value after assignment" do
    post = Post.first!
    post.thumbnail = "world"
    assert_equal "hello", post.thumbnail_was
  end

  test "binary column restore_thumbnail! restores the original value" do
    post = Post.first!
    post.thumbnail = "world"
    post.restore_thumbnail!
    assert_equal "hello", post.thumbnail
    assert_equal false, post.thumbnail_changed?
  end

  test "binary column clear_thumbnail_change clears dirty state" do
    post = Post.first!
    post.thumbnail = "world"
    post.clear_thumbnail_change
    assert_equal false, post.thumbnail_changed?
  end

  test "binary column will_save_change_to_thumbnail? returns false before change" do
    post = Post.first!
    assert_equal false, post.will_save_change_to_thumbnail?
  end

  test "binary column will_save_change_to_thumbnail? returns true after assignment" do
    post = Post.first!
    post.thumbnail = "world"
    assert post.will_save_change_to_thumbnail?
  end

  test "binary column thumbnail_change_to_be_saved returns nil before change" do
    post = Post.first!
    assert_nil post.thumbnail_change_to_be_saved
  end

  test "binary column thumbnail_change_to_be_saved returns pending change after assignment" do
    post = Post.first!
    post.thumbnail = "world"
    assert_equal ["hello", "world"], post.thumbnail_change_to_be_saved
  end

  test "binary column thumbnail_in_database returns the DB value" do
    post = Post.first!
    assert_equal "hello", post.thumbnail_in_database
  end

  # --- Dirty tracking: after save ---

  test "binary column thumbnail_previously_changed? returns true after save with change" do
    post = Post.first!
    post.thumbnail = "world"
    post.save!
    assert post.thumbnail_previously_changed?
  end

  test "binary column thumbnail_previous_change returns [old, new] after save" do
    post = Post.first!
    post.thumbnail = "world"
    post.save!
    assert_equal ["hello", "world"], post.thumbnail_previous_change
  end

  test "binary column thumbnail_previously_was returns old value after save" do
    post = Post.first!
    post.thumbnail = "world"
    post.save!
    assert_equal "hello", post.thumbnail_previously_was
  end

  test "binary column saved_change_to_thumbnail? returns false without save" do
    post = Post.first!
    assert_equal false, post.saved_change_to_thumbnail?
  end

  test "binary column saved_change_to_thumbnail? returns true after save with change" do
    post = Post.first!
    post.thumbnail = "world"
    post.save!
    assert post.saved_change_to_thumbnail?
  end

  test "binary column saved_change_to_thumbnail returns nil without save" do
    post = Post.first!
    assert_nil post.saved_change_to_thumbnail
  end

  test "binary column saved_change_to_thumbnail returns [old, new] after save" do
    post = Post.first!
    post.thumbnail = "world"
    post.save!
    assert_equal ["hello", "world"], post.saved_change_to_thumbnail
  end

  test "binary column thumbnail_before_last_save returns old value after save" do
    post = Post.first!
    post.thumbnail = "world"
    post.save!
    assert_equal "hello", post.thumbnail_before_last_save
  end
end

class PostPublishedTest < ActiveSupport::TestCase
  # --- getter / setter ---

  test "boolean column published is typed as bool" do
    post = Post.first!
    assert_equal true, post.published
  end

  test "boolean column published= sets a new bool value" do
    post = Post.first!
    post.published = false
    assert_equal false, post.published
  end

  # --- BeforeTypeCast / ForDatabase ---

  test "boolean column published_before_type_cast returns untyped" do
    post = Post.first!
    assert_equal 1, post.published_before_type_cast
  end

  test "boolean column published_for_database returns untyped" do
    post = Post.first!
    assert_equal true, post.published_for_database
  end

  # --- came_from_user? / query method ---

  test "boolean column published_came_from_user? returns false for DB-loaded record" do
    post = Post.first!
    assert_equal false, post.published_came_from_user?
  end

  test "boolean column published? returns bool" do
    post = Post.first!
    assert post.published?
  end

  # --- Dirty tracking: in-memory change ---

  test "boolean column published_changed? returns false before change" do
    post = Post.first!
    assert_equal false, post.published_changed?
  end

  test "boolean column published_changed? returns true after assignment" do
    post = Post.first!
    post.published = false
    assert post.published_changed?
  end

  test "boolean column published_change returns nil before change" do
    post = Post.first!
    assert_nil post.published_change
  end

  test "boolean column published_change returns [old, new] after assignment" do
    post = Post.first!
    post.published = false
    assert_equal [true, false], post.published_change
  end

  test "boolean column published_will_change! marks attribute as changed" do
    post = Post.first!
    post.published_will_change!
    assert post.published_changed?
  end

  test "boolean column published_was returns original value before change" do
    post = Post.first!
    assert_equal true, post.published_was
  end

  test "boolean column published_was returns old value after assignment" do
    post = Post.first!
    post.published = false
    assert_equal true, post.published_was
  end

  test "boolean column restore_published! restores the original value" do
    post = Post.first!
    post.published = false
    post.restore_published!
    assert_equal true, post.published
    assert_equal false, post.published_changed?
  end

  test "boolean column clear_published_change clears dirty state" do
    post = Post.first!
    post.published = false
    post.clear_published_change
    assert_equal false, post.published_changed?
  end

  test "boolean column will_save_change_to_published? returns false before change" do
    post = Post.first!
    assert_equal false, post.will_save_change_to_published?
  end

  test "boolean column will_save_change_to_published? returns true after assignment" do
    post = Post.first!
    post.published = false
    assert post.will_save_change_to_published?
  end

  test "boolean column published_change_to_be_saved returns nil before change" do
    post = Post.first!
    assert_nil post.published_change_to_be_saved
  end

  test "boolean column published_change_to_be_saved returns pending change after assignment" do
    post = Post.first!
    post.published = false
    assert_equal [true, false], post.published_change_to_be_saved
  end

  test "boolean column published_in_database returns the DB value" do
    post = Post.first!
    assert_equal true, post.published_in_database
  end

  # --- Dirty tracking: after save ---

  test "boolean column published_previously_changed? returns true after save with change" do
    post = Post.first!
    post.published = false
    post.save!
    assert post.published_previously_changed?
  end

  test "boolean column published_previous_change returns [old, new] after save" do
    post = Post.first!
    post.published = false
    post.save!
    assert_equal [true, false], post.published_previous_change
  end

  test "boolean column published_previously_was returns old value after save" do
    post = Post.first!
    post.published = false
    post.save!
    assert_equal true, post.published_previously_was
  end

  test "boolean column saved_change_to_published? returns false without save" do
    post = Post.first!
    assert_equal false, post.saved_change_to_published?
  end

  test "boolean column saved_change_to_published? returns true after save with change" do
    post = Post.first!
    post.published = false
    post.save!
    assert post.saved_change_to_published?
  end

  test "boolean column saved_change_to_published returns nil without save" do
    post = Post.first!
    assert_nil post.saved_change_to_published
  end

  test "boolean column saved_change_to_published returns [old, new] after save" do
    post = Post.first!
    post.published = false
    post.save!
    assert_equal [true, false], post.saved_change_to_published
  end

  test "boolean column published_before_last_save returns old value after save" do
    post = Post.first!
    post.published = false
    post.save!
    assert_equal true, post.published_before_last_save
  end
end

class PostLikesCountTest < ActiveSupport::TestCase
  # --- getter / setter ---

  test "integer column likes_count is typed as Integer" do
    post = Post.first!
    assert_equal 500, post.likes_count
  end

  test "integer column likes_count= sets a new Integer value" do
    post = Post.first!
    post.likes_count = 1_000
    assert_equal 1_000, post.likes_count
  end

  # --- BeforeTypeCast / ForDatabase ---

  test "integer column likes_count_before_type_cast returns untyped" do
    post = Post.first!
    assert_equal 500, post.likes_count_before_type_cast
  end

  test "integer column likes_count_for_database returns untyped" do
    post = Post.first!
    assert_equal 500, post.likes_count_for_database
  end

  # --- came_from_user? / query method ---

  test "integer column likes_count_came_from_user? returns false for DB-loaded record" do
    post = Post.first!
    assert_equal false, post.likes_count_came_from_user?
  end

  test "integer column likes_count? returns bool" do
    post = Post.first!
    assert post.likes_count?
  end

  # --- Dirty tracking: in-memory change ---

  test "integer column likes_count_changed? returns false before change" do
    post = Post.first!
    assert_equal false, post.likes_count_changed?
  end

  test "integer column likes_count_changed? returns true after assignment" do
    post = Post.first!
    post.likes_count = 1_000
    assert post.likes_count_changed?
  end

  test "integer column likes_count_change returns nil before change" do
    post = Post.first!
    assert_nil post.likes_count_change
  end

  test "integer column likes_count_change returns [old, new] after assignment" do
    post = Post.first!
    post.likes_count = 1_000
    assert_equal [500, 1_000], post.likes_count_change
  end

  test "integer column likes_count_will_change! marks attribute as changed" do
    post = Post.first!
    post.likes_count_will_change!
    assert post.likes_count_changed?
  end

  test "integer column likes_count_was returns original value before change" do
    post = Post.first!
    assert_equal 500, post.likes_count_was
  end

  test "integer column likes_count_was returns old value after assignment" do
    post = Post.first!
    post.likes_count = 1_000
    assert_equal 500, post.likes_count_was
  end

  test "integer column restore_likes_count! restores the original value" do
    post = Post.first!
    post.likes_count = 1_000
    post.restore_likes_count!
    assert_equal 500, post.likes_count
    assert_equal false, post.likes_count_changed?
  end

  test "integer column clear_likes_count_change clears dirty state" do
    post = Post.first!
    post.likes_count = 1_000
    post.clear_likes_count_change
    assert_equal false, post.likes_count_changed?
  end

  test "integer column will_save_change_to_likes_count? returns false before change" do
    post = Post.first!
    assert_equal false, post.will_save_change_to_likes_count?
  end

  test "integer column will_save_change_to_likes_count? returns true after assignment" do
    post = Post.first!
    post.likes_count = 1_000
    assert post.will_save_change_to_likes_count?
  end

  test "integer column likes_count_change_to_be_saved returns nil before change" do
    post = Post.first!
    assert_nil post.likes_count_change_to_be_saved
  end

  test "integer column likes_count_change_to_be_saved returns pending change after assignment" do
    post = Post.first!
    post.likes_count = 1_000
    assert_equal [500, 1_000], post.likes_count_change_to_be_saved
  end

  test "integer column likes_count_in_database returns the DB value" do
    post = Post.first!
    assert_equal 500, post.likes_count_in_database
  end

  # --- Dirty tracking: after save ---

  test "integer column likes_count_previously_changed? returns true after save with change" do
    post = Post.first!
    post.likes_count = 1_000
    post.save!
    assert post.likes_count_previously_changed?
  end

  test "integer column likes_count_previous_change returns [old, new] after save" do
    post = Post.first!
    post.likes_count = 1_000
    post.save!
    assert_equal [500, 1_000], post.likes_count_previous_change
  end

  test "integer column likes_count_previously_was returns old value after save" do
    post = Post.first!
    post.likes_count = 1_000
    post.save!
    assert_equal 500, post.likes_count_previously_was
  end

  test "integer column saved_change_to_likes_count? returns false without save" do
    post = Post.first!
    assert_equal false, post.saved_change_to_likes_count?
  end

  test "integer column saved_change_to_likes_count? returns true after save with change" do
    post = Post.first!
    post.likes_count = 1_000
    post.save!
    assert post.saved_change_to_likes_count?
  end

  test "integer column saved_change_to_likes_count returns nil without save" do
    post = Post.first!
    assert_nil post.saved_change_to_likes_count
  end

  test "integer column saved_change_to_likes_count returns [old, new] after save" do
    post = Post.first!
    post.likes_count = 1_000
    post.save!
    assert_equal [500, 1_000], post.saved_change_to_likes_count
  end

  test "integer column likes_count_before_last_save returns old value after save" do
    post = Post.first!
    post.likes_count = 1_000
    post.save!
    assert_equal 500, post.likes_count_before_last_save
  end
end

class PostRatingTest < ActiveSupport::TestCase
  ORIGINAL_RATING = 4.5
  NEW_RATING = 3.0

  # --- getter / setter ---

  test "float column rating is typed as Float" do
    post = Post.first!
    assert_equal ORIGINAL_RATING, post.rating
  end

  test "float column rating= sets a new Float value" do
    post = Post.first!
    post.rating = NEW_RATING
    assert_equal NEW_RATING, post.rating
  end

  # --- BeforeTypeCast / ForDatabase ---

  test "float column rating_before_type_cast returns untyped" do
    post = Post.first!
    assert_equal ORIGINAL_RATING, post.rating_before_type_cast
  end

  test "float column rating_for_database returns untyped" do
    post = Post.first!
    assert_equal ORIGINAL_RATING, post.rating_for_database
  end

  # --- came_from_user? / query method ---

  test "float column rating_came_from_user? returns false for DB-loaded record" do
    post = Post.first!
    assert_equal false, post.rating_came_from_user?
  end

  test "float column rating? returns bool" do
    post = Post.first!
    assert post.rating?
  end

  # --- Dirty tracking: in-memory change ---

  test "float column rating_changed? returns false before change" do
    post = Post.first!
    assert_equal false, post.rating_changed?
  end

  test "float column rating_changed? returns true after assignment" do
    post = Post.first!
    post.rating = NEW_RATING
    assert post.rating_changed?
  end

  test "float column rating_change returns nil before change" do
    post = Post.first!
    assert_nil post.rating_change
  end

  test "float column rating_change returns [old, new] after assignment" do
    post = Post.first!
    post.rating = NEW_RATING
    assert_equal [ORIGINAL_RATING, NEW_RATING], post.rating_change
  end

  test "float column rating_will_change! marks attribute as changed" do
    post = Post.first!
    post.rating_will_change!
    assert post.rating_changed?
  end

  test "float column rating_was returns original value before change" do
    post = Post.first!
    assert_equal ORIGINAL_RATING, post.rating_was
  end

  test "float column rating_was returns old value after assignment" do
    post = Post.first!
    post.rating = NEW_RATING
    assert_equal ORIGINAL_RATING, post.rating_was
  end

  test "float column restore_rating! restores the original value" do
    post = Post.first!
    post.rating = NEW_RATING
    post.restore_rating!
    assert_equal ORIGINAL_RATING, post.rating
    assert_equal false, post.rating_changed?
  end

  test "float column clear_rating_change clears dirty state" do
    post = Post.first!
    post.rating = NEW_RATING
    post.clear_rating_change
    assert_equal false, post.rating_changed?
  end

  test "float column will_save_change_to_rating? returns false before change" do
    post = Post.first!
    assert_equal false, post.will_save_change_to_rating?
  end

  test "float column will_save_change_to_rating? returns true after assignment" do
    post = Post.first!
    post.rating = NEW_RATING
    assert post.will_save_change_to_rating?
  end

  test "float column rating_change_to_be_saved returns nil before change" do
    post = Post.first!
    assert_nil post.rating_change_to_be_saved
  end

  test "float column rating_change_to_be_saved returns pending change after assignment" do
    post = Post.first!
    post.rating = NEW_RATING
    assert_equal [ORIGINAL_RATING, NEW_RATING], post.rating_change_to_be_saved
  end

  test "float column rating_in_database returns the DB value" do
    post = Post.first!
    assert_equal ORIGINAL_RATING, post.rating_in_database
  end

  # --- Dirty tracking: after save ---

  test "float column rating_previously_changed? returns true after save with change" do
    post = Post.first!
    post.rating = NEW_RATING
    post.save!
    assert post.rating_previously_changed?
  end

  test "float column rating_previous_change returns [old, new] after save" do
    post = Post.first!
    post.rating = NEW_RATING
    post.save!
    assert_equal [ORIGINAL_RATING, NEW_RATING], post.rating_previous_change
  end

  test "float column rating_previously_was returns old value after save" do
    post = Post.first!
    post.rating = NEW_RATING
    post.save!
    assert_equal ORIGINAL_RATING, post.rating_previously_was
  end

  test "float column saved_change_to_rating? returns false without save" do
    post = Post.first!
    assert_equal false, post.saved_change_to_rating?
  end

  test "float column saved_change_to_rating? returns true after save with change" do
    post = Post.first!
    post.rating = NEW_RATING
    post.save!
    assert post.saved_change_to_rating?
  end

  test "float column saved_change_to_rating returns nil without save" do
    post = Post.first!
    assert_nil post.saved_change_to_rating
  end

  test "float column saved_change_to_rating returns [old, new] after save" do
    post = Post.first!
    post.rating = NEW_RATING
    post.save!
    assert_equal [ORIGINAL_RATING, NEW_RATING], post.saved_change_to_rating
  end

  test "float column rating_before_last_save returns old value after save" do
    post = Post.first!
    post.rating = NEW_RATING
    post.save!
    assert_equal ORIGINAL_RATING, post.rating_before_last_save
  end
end

class PostPriceTest < ActiveSupport::TestCase
  ORIGINAL_PRICE = BigDecimal("9.99")
  NEW_PRICE = BigDecimal("19.99")

  # --- getter / setter ---

  test "decimal column price is typed as BigDecimal" do
    post = Post.first!
    assert_equal ORIGINAL_PRICE, post.price
  end

  test "decimal column price= sets a new BigDecimal value" do
    post = Post.first!
    post.price = NEW_PRICE
    assert_equal NEW_PRICE, post.price
  end

  # --- BeforeTypeCast / ForDatabase ---

  test "decimal column price_before_type_cast returns untyped" do
    post = Post.first!
    assert_equal ORIGINAL_PRICE, post.price_before_type_cast
  end

  test "decimal column price_for_database returns untyped" do
    post = Post.first!
    assert_equal ORIGINAL_PRICE, post.price_for_database
  end

  # --- came_from_user? / query method ---

  test "decimal column price_came_from_user? returns false for DB-loaded record" do
    post = Post.first!
    assert_equal false, post.price_came_from_user?
  end

  test "decimal column price? returns bool" do
    post = Post.first!
    assert post.price?
  end

  # --- Dirty tracking: in-memory change ---

  test "decimal column price_changed? returns false before change" do
    post = Post.first!
    assert_equal false, post.price_changed?
  end

  test "decimal column price_changed? returns true after assignment" do
    post = Post.first!
    post.price = NEW_PRICE
    assert post.price_changed?
  end

  test "decimal column price_change returns nil before change" do
    post = Post.first!
    assert_nil post.price_change
  end

  test "decimal column price_change returns [old, new] after assignment" do
    post = Post.first!
    post.price = NEW_PRICE
    assert_equal [ORIGINAL_PRICE, NEW_PRICE], post.price_change
  end

  test "decimal column price_will_change! marks attribute as changed" do
    post = Post.first!
    post.price_will_change!
    assert post.price_changed?
  end

  test "decimal column price_was returns original value before change" do
    post = Post.first!
    assert_equal ORIGINAL_PRICE, post.price_was
  end

  test "decimal column price_was returns old value after assignment" do
    post = Post.first!
    post.price = NEW_PRICE
    assert_equal ORIGINAL_PRICE, post.price_was
  end

  test "decimal column restore_price! restores the original value" do
    post = Post.first!
    post.price = NEW_PRICE
    post.restore_price!
    assert_equal ORIGINAL_PRICE, post.price
    assert_equal false, post.price_changed?
  end

  test "decimal column clear_price_change clears dirty state" do
    post = Post.first!
    post.price = NEW_PRICE
    post.clear_price_change
    assert_equal false, post.price_changed?
  end

  test "decimal column will_save_change_to_price? returns false before change" do
    post = Post.first!
    assert_equal false, post.will_save_change_to_price?
  end

  test "decimal column will_save_change_to_price? returns true after assignment" do
    post = Post.first!
    post.price = NEW_PRICE
    assert post.will_save_change_to_price?
  end

  test "decimal column price_change_to_be_saved returns nil before change" do
    post = Post.first!
    assert_nil post.price_change_to_be_saved
  end

  test "decimal column price_change_to_be_saved returns pending change after assignment" do
    post = Post.first!
    post.price = NEW_PRICE
    assert_equal [ORIGINAL_PRICE, NEW_PRICE], post.price_change_to_be_saved
  end

  test "decimal column price_in_database returns the DB value" do
    post = Post.first!
    assert_equal ORIGINAL_PRICE, post.price_in_database
  end

  # --- Dirty tracking: after save ---

  test "decimal column price_previously_changed? returns true after save with change" do
    post = Post.first!
    post.price = NEW_PRICE
    post.save!
    assert post.price_previously_changed?
  end

  test "decimal column price_previous_change returns [old, new] after save" do
    post = Post.first!
    post.price = NEW_PRICE
    post.save!
    assert_equal [ORIGINAL_PRICE, NEW_PRICE], post.price_previous_change
  end

  test "decimal column price_previously_was returns old value after save" do
    post = Post.first!
    post.price = NEW_PRICE
    post.save!
    assert_equal ORIGINAL_PRICE, post.price_previously_was
  end

  test "decimal column saved_change_to_price? returns false without save" do
    post = Post.first!
    assert_equal false, post.saved_change_to_price?
  end

  test "decimal column saved_change_to_price? returns true after save with change" do
    post = Post.first!
    post.price = NEW_PRICE
    post.save!
    assert post.saved_change_to_price?
  end

  test "decimal column saved_change_to_price returns nil without save" do
    post = Post.first!
    assert_nil post.saved_change_to_price
  end

  test "decimal column saved_change_to_price returns [old, new] after save" do
    post = Post.first!
    post.price = NEW_PRICE
    post.save!
    assert_equal [ORIGINAL_PRICE, NEW_PRICE], post.saved_change_to_price
  end

  test "decimal column price_before_last_save returns old value after save" do
    post = Post.first!
    post.price = NEW_PRICE
    post.save!
    assert_equal ORIGINAL_PRICE, post.price_before_last_save
  end
end

class PostPublishedOnTest < ActiveSupport::TestCase
  ORIGINAL_PUBLISHED_ON = Date.new(2024, 1, 1)
  NEW_PUBLISHED_ON = Date.new(2099, 1, 1)

  # --- getter / setter ---

  test "date column published_on is typed as Date" do
    post = Post.first!
    assert_equal ORIGINAL_PUBLISHED_ON, post.published_on
  end

  test "date column published_on= sets a new Date value" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    assert_equal NEW_PUBLISHED_ON, post.published_on
  end

  # --- BeforeTypeCast / ForDatabase ---

  test "date column published_on_before_type_cast returns untyped" do
    post = Post.first!
    assert_equal "2024-01-01", post.published_on_before_type_cast
  end

  test "date column published_on_for_database returns untyped" do
    post = Post.first!
    assert_equal ORIGINAL_PUBLISHED_ON, post.published_on_for_database
  end

  # --- came_from_user? / query method ---

  test "date column published_on_came_from_user? returns false for DB-loaded record" do
    post = Post.first!
    assert_equal false, post.published_on_came_from_user?
  end

  test "date column published_on? returns bool" do
    post = Post.first!
    assert post.published_on?
  end

  # --- Dirty tracking: in-memory change ---

  test "date column published_on_changed? returns false before change" do
    post = Post.first!
    assert_equal false, post.published_on_changed?
  end

  test "date column published_on_changed? returns true after assignment" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    assert post.published_on_changed?
  end

  test "date column published_on_change returns nil before change" do
    post = Post.first!
    assert_nil post.published_on_change
  end

  test "date column published_on_change returns [old, new] after assignment" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    assert_equal [ORIGINAL_PUBLISHED_ON, NEW_PUBLISHED_ON], post.published_on_change
  end

  test "date column published_on_will_change! marks attribute as changed" do
    post = Post.first!
    post.published_on_will_change!
    assert post.published_on_changed?
  end

  test "date column published_on_was returns original value before change" do
    post = Post.first!
    assert_equal ORIGINAL_PUBLISHED_ON, post.published_on_was
  end

  test "date column published_on_was returns old value after assignment" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    assert_equal ORIGINAL_PUBLISHED_ON, post.published_on_was
  end

  test "date column restore_published_on! restores the original value" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    post.restore_published_on!
    assert_equal ORIGINAL_PUBLISHED_ON, post.published_on
    assert_equal false, post.published_on_changed?
  end

  test "date column clear_published_on_change clears dirty state" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    post.clear_published_on_change
    assert_equal false, post.published_on_changed?
  end

  test "date column will_save_change_to_published_on? returns false before change" do
    post = Post.first!
    assert_equal false, post.will_save_change_to_published_on?
  end

  test "date column will_save_change_to_published_on? returns true after assignment" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    assert post.will_save_change_to_published_on?
  end

  test "date column published_on_change_to_be_saved returns nil before change" do
    post = Post.first!
    assert_nil post.published_on_change_to_be_saved
  end

  test "date column published_on_change_to_be_saved returns pending change after assignment" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    assert_equal [ORIGINAL_PUBLISHED_ON, NEW_PUBLISHED_ON], post.published_on_change_to_be_saved
  end

  test "date column published_on_in_database returns the DB value" do
    post = Post.first!
    assert_equal ORIGINAL_PUBLISHED_ON, post.published_on_in_database
  end

  # --- Dirty tracking: after save ---

  test "date column published_on_previously_changed? returns true after save with change" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    post.save!
    assert post.published_on_previously_changed?
  end

  test "date column published_on_previous_change returns [old, new] after save" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    post.save!
    assert_equal [ORIGINAL_PUBLISHED_ON, NEW_PUBLISHED_ON], post.published_on_previous_change
  end

  test "date column published_on_previously_was returns old value after save" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    post.save!
    assert_equal ORIGINAL_PUBLISHED_ON, post.published_on_previously_was
  end

  test "date column saved_change_to_published_on? returns false without save" do
    post = Post.first!
    assert_equal false, post.saved_change_to_published_on?
  end

  test "date column saved_change_to_published_on? returns true after save with change" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    post.save!
    assert post.saved_change_to_published_on?
  end

  test "date column saved_change_to_published_on returns nil without save" do
    post = Post.first!
    assert_nil post.saved_change_to_published_on
  end

  test "date column saved_change_to_published_on returns [old, new] after save" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    post.save!
    assert_equal [ORIGINAL_PUBLISHED_ON, NEW_PUBLISHED_ON], post.saved_change_to_published_on
  end

  test "date column published_on_before_last_save returns old value after save" do
    post = Post.first!
    post.published_on = NEW_PUBLISHED_ON
    post.save!
    assert_equal ORIGINAL_PUBLISHED_ON, post.published_on_before_last_save
  end
end

class PostCreatedAtTest < ActiveSupport::TestCase
  ORIGINAL_CREATED_AT = Time.utc(2024, 1, 1)
  NEW_CREATED_AT = Time.utc(2099, 1, 1)

  test "datetime column created_at is typed as ActiveSupport::TimeWithZone" do
    post = Post.first!
    assert_instance_of ActiveSupport::TimeWithZone, post.created_at
  end

  test "datetime column created_at= sets a new Time value" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    assert_equal NEW_CREATED_AT, post.created_at
  end

  test "datetime column created_at_before_type_cast returns untyped" do
    post = Post.first!
    assert_equal "2024-01-01 00:00:00", post.created_at_before_type_cast
  end

  test "datetime column created_at_for_database returns ActiveSupport::TimeWithZone" do
    post = Post.first!
    assert_equal ORIGINAL_CREATED_AT, post.created_at_for_database
  end

  test "datetime column created_at_came_from_user? returns false for DB-loaded record" do
    post = Post.first!
    assert_equal false, post.created_at_came_from_user?
  end

  test "datetime column created_at? returns true for non-nil value" do
    post = Post.first!
    assert post.created_at?
  end

  test "datetime column created_at_changed? returns false before change" do
    post = Post.first!
    assert_equal false, post.created_at_changed?
  end

  test "datetime column created_at_changed? returns true after assignment" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    assert post.created_at_changed?
  end

  test "datetime column created_at_change returns nil before change" do
    post = Post.first!
    assert_nil post.created_at_change
  end

  test "datetime column created_at_change returns [old, new] after assignment" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    assert_equal [ORIGINAL_CREATED_AT, NEW_CREATED_AT], post.created_at_change
  end

  test "datetime column created_at_will_change! marks attribute as changed" do
    post = Post.first!
    post.created_at_will_change!
    assert post.created_at_changed?
  end

  test "datetime column created_at_was returns original value before change" do
    post = Post.first!
    assert_equal ORIGINAL_CREATED_AT, post.created_at_was
  end

  test "datetime column created_at_was returns old value after assignment" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    assert_equal ORIGINAL_CREATED_AT, post.created_at_was
  end

  test "datetime column restore_created_at! restores the original value" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    post.restore_created_at!
    assert_equal ORIGINAL_CREATED_AT, post.created_at
    assert_equal false, post.created_at_changed?
  end

  test "datetime column clear_created_at_change clears dirty state" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    post.clear_created_at_change
    assert_equal false, post.created_at_changed?
  end

  test "datetime column will_save_change_to_created_at? returns false before change" do
    post = Post.first!
    assert_equal false, post.will_save_change_to_created_at?
  end

  test "datetime column will_save_change_to_created_at? returns true after assignment" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    assert post.will_save_change_to_created_at?
  end

  test "datetime column created_at_change_to_be_saved returns nil before change" do
    post = Post.first!
    assert_nil post.created_at_change_to_be_saved
  end

  test "datetime column created_at_change_to_be_saved returns pending change after assignment" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    assert_equal [ORIGINAL_CREATED_AT, NEW_CREATED_AT], post.created_at_change_to_be_saved
  end

  test "datetime column created_at_in_database returns the DB value" do
    post = Post.first!
    assert_equal ORIGINAL_CREATED_AT, post.created_at_in_database
  end

  test "datetime column created_at_previously_changed? returns true after save with change" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    post.save!
    assert post.created_at_previously_changed?
  end

  test "datetime column created_at_previous_change returns [old, new] after save" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    post.save!
    assert_equal [ORIGINAL_CREATED_AT, NEW_CREATED_AT], post.created_at_previous_change
  end

  test "datetime column created_at_previously_was returns old value after save" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    post.save!
    assert_equal ORIGINAL_CREATED_AT, post.created_at_previously_was
  end

  test "datetime column saved_change_to_created_at? returns false without save" do
    post = Post.first!
    assert_equal false, post.saved_change_to_created_at?
  end

  test "datetime column saved_change_to_created_at? returns true after save with change" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    post.save!
    assert post.saved_change_to_created_at?
  end

  test "datetime column saved_change_to_created_at returns nil without save" do
    post = Post.first!
    assert_nil post.saved_change_to_created_at
  end

  test "datetime column saved_change_to_created_at returns [old, new] after save" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    post.save!
    assert_equal [ORIGINAL_CREATED_AT, NEW_CREATED_AT], post.saved_change_to_created_at
  end

  test "datetime column created_at_before_last_save returns old value after save" do
    post = Post.first!
    post.created_at = NEW_CREATED_AT
    post.save!
    assert_equal ORIGINAL_CREATED_AT, post.created_at_before_last_save
  end
end
