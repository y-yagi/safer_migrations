# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "debug"
require "safer_migrations"
require_relative "migrations"
require "minitest/autorun"

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new(File::NULL)

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :name
  end

  create_table :products do |t|
    t.string :name
  end
end

class User < ActiveRecord::Base
end

class Product < ActiveRecord::Base
  self.ignored_columns = [:name]
end