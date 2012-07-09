require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  setup do
    @tag = tags(:tag_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tags)
  end
end
