# frozen_string_literal: true

require "test_helper"

class TestSaferMigrations < Minitest::Test
  def test_unsafe_remove_column
    error = assert_raises(SaferMigrations::DangerousMigrationError) do
      RemoveNameFromUsersBySaferRemoveColumn.migrate(:up)
    end
    assert_equal "'User' model still uses 'name'", error.message
  end

  def test_safe_remove_column
    RemoveNameFromProductsBySaferRemoveColumn.migrate(:up)
    assert_equal ["id"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys

    Product.reset_column_information
    RemoveNameFromProductsBySaferRemoveColumn.migrate(:down)
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys
  ensure
    RemoveNameFromProductsBySaferRemoveColumn.add_column(:products, :name, :string, if_not_exists: true)
  end

  def test_unsafe_remove_columns
    error = assert_raises(SaferMigrations::DangerousMigrationError) do
      RemoveNameFromUsersBySaferRemoveColumns.migrate(:up)
    end
    assert_equal "'User' model still uses 'name'", error.message
  end

  def test_safe_remove_columns
    RemoveNameFromProductsBySaferRemoveColumns.migrate(:up)
    Product.reset_column_information
    assert_equal ["id"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys

    Product.reset_column_information
    RemoveNameFromProductsBySaferRemoveColumns.migrate(:down)
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys
  ensure
    RemoveNameFromProductsBySaferRemoveColumns.add_column(:products, :name, :string, if_not_exists: true)
  end

  def test_unsafe_rename_column
    error = assert_raises(SaferMigrations::DangerousMigrationError) do
      SaferRenameNameInUsers.migrate(:up)
    end
    assert_equal "'User' model still uses 'name'", error.message
  end

  def test_safe_rename_column
    SaferRenameNameInProducts.migrate(:up)
    assert_equal ["id", "new_name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys

    Product.reset_column_information
    SaferRenameNameInProducts.migrate(:down)
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys
  end

  def test_unsafe_remove_column_with_change_table
    error = assert_raises(SaferMigrations::DangerousMigrationError) do
      SaferRemoveNameFromUsersByChangeTableRemove.migrate(:up)
    end
    assert_equal "'User' model still uses 'name'", error.message
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("users").keys
  end

  def test_safe_remove_column_with_change_table
    SaferRemoveNameFromProductsByChangeTableRemove.migrate(:up)
    assert_equal ["id"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys

    Product.reset_column_information
    SaferRemoveNameFromProductsByChangeTableRemove.migrate(:down)
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys
  end

  def test_unsafe_rename_column_with_change_table
    error = assert_raises(SaferMigrations::DangerousMigrationError) do
      SaferRenameNameFromUsersByChangeTable.migrate(:up)
    end
    assert_equal "'User' model still uses 'name'", error.message
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("users").keys
  end

  def test_safe_rename_column_with_change_table
    SaferRenameNameFromProductsByChangeTable.migrate(:up)
    assert_equal ["id", "new_name", "price"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys

    Product.reset_column_information
    SaferRenameNameFromProductsByChangeTable.migrate(:down)
    assert_equal ["id", "name"], ActiveRecord::Base.connection.schema_cache.columns_hash("products").keys
  end
end
