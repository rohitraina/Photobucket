require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  test "album_validity" do
    assert albums(:album_one).valid?
  end

  test "album_invalidity" do
    album = albums(:invalid_album)
    assert album.valid?
    assert album.errors.invalid?(:title)
    assert album.errors.invalid?(:path)
  end
  
  test "uniqueness_of_path" do
    album = Album.new(
      :path => albums(:album_two).path,
      :title => "Test Title",
      :description => "Nothing")
  
    assert !album.valid?
    assert album.errors.invalid?(:path)
    assert_equal "has already been taken", album.errors.on(:path)
  end
end
