# frozen_string_literal: true

require "test_helper"

class TestSaferMigrations < Minitest::Test
  def test_unsafe_remove_column
    error = assert_raises(SaferMigrations::DangerousMigrationError) do
      RemoveNameFromUsersByRemoveColumn.migrate(:up)
    end
    assert_equal "'User' model still uses 'name'", error.message
  end

  def test_safe_remove_column
    RemoveNameFromProductsByRemoveColumn.migrate(:up)
    assert_equal ["id"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys

    Product.reset_column_information
    RemoveNameFromProductsByRemoveColumn.migrate(:down)
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys
  ensure
    RemoveNameFromProductsByRemoveColumn.add_column(:products, :name, :string, if_not_exists: true)
  end

  def test_unsafe_remove_columns
    error = assert_raises(SaferMigrations::DangerousMigrationError) do
      RemoveNameFromUsersByRemoveColumns.migrate(:up)
    end
    assert_equal "'User' model still uses 'name'", error.message
  end

  def test_safe_remove_columns
    RemoveNameFromProductsByRemoveColumns.migrate(:up)
    assert_equal ["id"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys

    Product.reset_column_information
    RemoveNameFromProductsByRemoveColumns.migrate(:down)
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys
  ensure
    RemoveNameFromProductsByRemoveColumns.add_column(:products, :name, :string, if_not_exists: true)
  end

  def test_unsafe_rename_column
    error = assert_raises(SaferMigrations::DangerousMigrationError) do
      RenameNameInUsers.migrate(:up)
    end
    assert_equal "'User' model still uses 'name'", error.message
  end

  def test_safe_rename_column
    RenameNameInProducts.migrate(:up)
    assert_equal ["id", "new_name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys

    Product.reset_column_information
    RenameNameInProducts.migrate(:down)
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys
  end

  def test_unsafe_remove_column_with_change_table
    error = assert_raises(SaferMigrations::DangerousMigrationError) do
      RemoveNameFromUsersByChangeTableRemove.migrate(:up)
    end
    assert_equal "'User' model still uses 'name'", error.message
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys
  end

  def test_safe_remove_column_with_change_table
    RemoveNameFromProductsByChangeTableRemove.migrate(:up)
    assert_equal ["id"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys

    RemoveNameFromProductsByChangeTableRemove.migrate(:down)
    Product.reset_column_information
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys
  end
end