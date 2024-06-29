# frozen_string_literal: true

require "active_support"
require "active_record"

require_relative "safer_migrations/version"
require_relative "safer_migrations/errors"
require_relative "safer_migrations/command_recorder"
require_relative "safer_migrations/schema_statements"

ActiveSupport.on_load(:active_record) do
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend(SaferMigrations::SchemaStatements)
  ActiveRecord::Migration::CommandRecorder.prepend(SaferMigrations::CommandRecorder)
end
