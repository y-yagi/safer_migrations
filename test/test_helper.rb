# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "debug"
require "safer_migrations"
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

class RemoveNameFromUsersByRemoveColumn < ActiveRecord::Migration::Current
  def change
    safer_remove_column :users, :name
  end
end

class RemoveNameFromProductsByRemoveColumn < ActiveRecord::Migration::Current
  def change
    safer_remove_column :products, :name, :string
  end
end

class RemoveNameFromUsersByRemoveColumns < ActiveRecord::Migration::Current
  def change
    safer_remove_columns :users, :name
  end
end

class RemoveNameFromProductsByRemoveColumns < ActiveRecord::Migration::Current
  def change
    safer_remove_columns :products, :name, type: :string
  end
end

class RenameNameInUsers < ActiveRecord::Migration::Current
  def change
    safer_rename_column :users, :name, :new_name
  end
end

class RenameNameInProducts < ActiveRecord::Migration::Current
  def change
    safer_rename_column :products, :name, :new_name
  end
end
