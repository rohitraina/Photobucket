require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "uniqueness_of_title" do
    tag = Tag.new(:title => tags(:tag_one).title)
      
    assert !tag.valid?
    assert tag.errors.invalid?(:title)
    assert_equal "has already been taken", tag.errors.on(:path)
  end
end
