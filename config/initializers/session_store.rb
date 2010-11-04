# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_OE_session',
  :secret      => '3eacdb80b1ac20777b423b60d4d4a3d8d1a3f1de5cb83fecf5a702673b74abc972437bb5fa27f9a67b2d32d7f9f3d72cc3bc83e4a2c79af93a1043c6b59be7d4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
