# frozen_string_literal: true

module SaferMigrations
  module TableDefinition
    def safer_remove(*column_names, **options)
      @base.safer_remove_columns(name, *column_names, **options)
    end
  end
end
