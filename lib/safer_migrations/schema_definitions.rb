# frozen_string_literal: true

module SaferMigrations
  module TableDefinition
    def safer_remove(*column_names, **options)
      @base.safer_remove_columns(name, *column_names, **options)
    end

    def safer_rename(column_name, new_column_name)
      @base.safer_rename_column(name, column_name, new_column_name)
    end
  end
end
