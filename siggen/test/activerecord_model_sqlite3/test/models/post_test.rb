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
end
