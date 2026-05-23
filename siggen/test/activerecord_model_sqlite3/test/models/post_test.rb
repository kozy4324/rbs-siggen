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
