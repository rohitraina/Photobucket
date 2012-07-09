require 'test_helper'

class BucketTest < ActiveSupport::TestCase
  test "bucket_validity" do
    assert buckets(:bucket_yash).valid?
  end

  test "bucket_invalidity" do
    bucket = buckets(:invalid_bucket)
    assert !bucket.valid?
    assert bucket.errors.invalid?(:title)
  end
end
