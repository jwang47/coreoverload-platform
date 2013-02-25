# Load the rails application
require File.expand_path('../application', __FILE__)

# the amount of time passed (according to GameServer.heartbeat_elapsed())
# before we destroy the GameServer
GS_HEARTBEAT_LIMIT = 30

# Initialize the rails application
CoPlatform::Application.initialize!
