# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# Set token based on intialize_secret function (defined in initializers/secret_generator.rb)
TapForBlood::Application.config.secret_token =
    'a53a8cef9e9c513234e270e4ee24531b0180d59bd8e60e24261560b971103a39a816f0ec08dcf76d161370df235290a7b36fabcb21c37f69db788739b51afcc3'
