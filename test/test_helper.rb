# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "debug"
require "safer_migrations"
require_relative "migrations"
require "minitest/autorun"

if ENV["ENFORCE_SAFER_METHODS"] == "true"
  SaferMigrations.enforce_safer_methods = true
end

if ENV["ADAPTER"]
  ActiveRecord::Base.establish_connection(adapter: ENV["ADAPTER"], database: "safer_migrations_test", host: "127.0.0.1")
else
  ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
end

if ENV["DEBUG"]
  ActiveRecord::Base.logger = Logger.new(STDOUT)
else
  ActiveRecord::Base.logger = Logger.new(File::NULL)
  ActiveRecord::Migration.verbose = false
end

ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
  end

  create_table :products, force: true do |t|
    t.string :name
  end
end

class User < ActiveRecord::Base
end

class Product < ActiveRecord::Base
  self.ignored_columns = [:name, :new_name, :price]
end
