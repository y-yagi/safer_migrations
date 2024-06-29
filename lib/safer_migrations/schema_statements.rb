# frozen_string_literal: true

module SaferMigrations
  module SchemaStatements
    def safer_remove_column(table_name, column_name, type = nil, **options)
      validate_remove_column(table_name, column_name)
      remove_column(table_name, column_name, type = nil, **options)
    end

    def safer_remove_columns(table_name, *column_names, type: nil, **options)
      column_names.each do |column_name|
        validate_remove_column(table_name, column_name)
      end
      remove_columns(table_name, *column_names, type = nil, **options)
    end

    private

    def validate_remove_column(table_name, column_name)
      model = table_name.to_s.classify.constantize
      if model.column_names.include?(column_name.to_s)
        raise SaferMigrations::DangerousMigrationError, "'#{model}' model still uses '#{column_name}'"
      end
    end
  end
end
