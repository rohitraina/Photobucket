# Load the rails application
require File.expand_path('../application', __FILE__)

# Load app vars from local file
bucket_env = File.join(Rails.root, 'config', 'bucket.rb')
load(bucket_env) if File.exists?(bucket_env)

# Initialize the rails application
Photobucket::Application.initialize!
