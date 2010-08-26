# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_openstanza_session',
  :secret      => 'f85951abb5070475a0f450a08fac4df43fc05c5adcc6a855f9cda393a3d17b75cda25f740048ed1d1be4b4d3b01bf3d99b549643f3ede27e3924a82dc5423772'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
