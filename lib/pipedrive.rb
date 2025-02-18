require 'logger'
require 'active_support/core_ext/hash'
require 'active_support/concern'
require 'active_support/inflector'

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'person', 'persons'
end

require 'hashie'
require 'faraday'
require 'faraday_middleware'
require 'pipedrive/version'

module Pipedrive
  extend self
  attr_accessor :api_token, :debug
  attr_writer :user_agent, :logger

  # ensures the setup only gets run once
  @_ran_once = false

  def reset!
    @logger = nil
    @_ran_once = false
    @user_agent = nil
    @api_token = nil
  end

  def user_agent
    @user_agent ||= "Pipedrive Ruby Client v#{::Pipedrive::VERSION}"
  end

  def setup
    yield self unless @_ran_once
    @_ran_once = true
  end

  def logger
    @logger ||= Logger.new(STDOUT)
  end

  reset!
end

require 'pipedrive/railties' if defined?(::Rails)

# Core
require 'pipedrive/base'
require 'pipedrive/client'
require 'pipedrive/connection'
require 'pipedrive/utils'
require 'pipedrive/operations/create'
require 'pipedrive/operations/read'
require 'pipedrive/operations/update'
require 'pipedrive/operations/delete'

# Persons
require 'pipedrive/person_field'
require 'pipedrive/person'

# Organizations
require 'pipedrive/organization_field'
require 'pipedrive/organization'

# Filters
require 'pipedrive/filter'

# Products
require 'pipedrive/product_field'
require 'pipedrive/product'

# Roles
require 'pipedrive/role'

# Stages
require 'pipedrive/stage'

# Goals
require 'pipedrive/goal'

# Activities
require 'pipedrive/activity'
require 'pipedrive/activity_type'

# Deals
require 'pipedrive/deal_field'
require 'pipedrive/deal'

# Files
require 'pipedrive/file'

# Notes
require 'pipedrive/note'

# Users
require 'pipedrive/user'

# Search results
require 'pipedrive/search_results'

# Pipeline
require 'pipedrive/pipeline'
