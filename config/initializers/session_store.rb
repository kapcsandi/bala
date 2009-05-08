# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bala_session',
  :secret      => '7406d72799e1b5bf370728dc6c74a3ce4a6acd2f6650a2a7158f346531b62a7e8438f58fda7a432aee8aea97559093914d80700773a89fe6a2367a23408a406f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
