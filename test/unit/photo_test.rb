require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  test "photo_validity" do
    assert photos(:photo_one).valid?
  end

  test "photo_invalidity" do
    photo = photos(:invalid_photo)
    assert photo.valid?
    assert photo.errors.invalid?(:title)
  end
end
