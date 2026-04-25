require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "the truth" do
    post = Post.first
    assert_equal "MyString", post.title
  end
end
