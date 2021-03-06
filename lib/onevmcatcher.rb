require 'active_support/all'
require 'settingslogic'
require 'multi_json'
require 'mixlib/shellout'
require 'logger'
require 'uri'
require 'erb'
require 'hashie/mash'

# Wraps all internals of the handler.
module Onevmcatcher; end

require 'onevmcatcher/version'
require 'onevmcatcher/settings'
require 'onevmcatcher/log'
require 'onevmcatcher/errors'
require 'onevmcatcher/helpers'
require 'onevmcatcher/event_handlers'
require 'onevmcatcher/metadata_archiver'
require 'onevmcatcher/image_syncmaster'
require 'onevmcatcher/image_transformer'
require 'onevmcatcher/vmcatcher_env'
require 'onevmcatcher/vmcatcher_configuration'
require 'onevmcatcher/vmcatcher_event'
