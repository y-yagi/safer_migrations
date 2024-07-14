# frozen_string_literal: true

require "test_helper"

class TestRailsMigrations < Minitest::Test
  def test_remove_column
    RemoveNameFromUsersByRemoveColumn.migrate(:up)
    User.reset_column_information
    assert_equal ["id"], ActiveRecord::Base.connection.schema_cache.columns_hash("users").keys
  ensure
    RemoveNameFromUsersByRemoveColumn.migrate(:down)
    User.reset_column_information
  end

  def test_remove_columns
    RemoveNameFromUsersByRemoveColumns.migrate(:up)
    User.reset_column_information
    assert_equal ["id"], ActiveRecord::Base.connection.schema_cache.columns_hash("users").keys
  ensure
    RemoveNameFromUsersByRemoveColumns.migrate(:down)
    User.reset_column_information
  end

  def test_rename_column
    RenameNameInUsers.migrate(:up)
    User.reset_column_information
    assert_equal ["id", "new_name"], ActiveRecord::Base.connection.schema_cache.columns_hash("users").keys
  ensure
    RenameNameInUsers.migrate(:down)
    User.reset_column_information
  end

  def test_remove_column_with_change_table
    RemoveNameFromUsersByChangeTableRemove.migrate(:up)
    User.reset_column_information
    assert_equal ["id"], ActiveRecord::Base.connection.schema_cache.columns_hash("users").keys
  ensure
    RemoveNameFromUsersByChangeTableRemove.migrate(:down)
    User.reset_column_information
  end

  def test_rename_column_with_change_table
    RenameNameFromUsersByChangeTable.migrate(:up)
    User.reset_column_information
    assert_equal ["id", "new_name"], ActiveRecord::Base.connection.schema_cache.columns_hash("users").keys
  ensure
    RenameNameFromUsersByChangeTable.migrate(:down)
    User.reset_column_information
  end
end
