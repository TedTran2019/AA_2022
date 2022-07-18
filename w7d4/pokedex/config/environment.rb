# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Convert to camelcase
Jbuilder.key_format camelize: :lower
