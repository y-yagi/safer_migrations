# frozen_string_literal: true

require "active_support"
require "active_record"

module SaferMigrations
  class << self
    attr_accessor :enforce_safer_methods
  end
end

require_relative "safer_migrations/version"
require_relative "safer_migrations/errors"

ActiveSupport.on_load(:active_record) do
  require_relative "safer_migrations/command_recorder"
  require_relative "safer_migrations/schema_definitions"

  ActiveRecord::ConnectionAdapters::Table.prepend(SaferMigrations::TableDefinition)
  ActiveRecord::Migration::CommandRecorder.prepend(SaferMigrations::CommandRecorder)
end

ActiveSupport.on_load(:active_record_sqlite3adapter) do
  require_relative "safer_migrations/schema_statements"
  self.prepend(SaferMigrations::SchemaStatements)
end

ActiveSupport.on_load(:active_record_mysql2adapter) do
  require_relative "safer_migrations/schema_statements"
  self.prepend(SaferMigrations::SchemaStatements)
end

ActiveSupport.on_load(:active_record_trilogyadapter) do
  require_relative "safer_migrations/schema_statements"
  self.prepend(SaferMigrations::SchemaStatements)
end

ActiveSupport.on_load(:active_record_postgresqladapter) do
  require_relative "safer_migrations/schema_statements"
  self.prepend(SaferMigrations::SchemaStatements)
end
