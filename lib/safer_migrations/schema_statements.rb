# frozen_string_literal: true

module SaferMigrations
  module SchemaStatements
    if SaferMigrations.enforce_safer_methods
      def remove_column(table_name, column_name, type = nil, **options)
        validate_remove_column(table_name, column_name)
        super
      end

      def remove_columns(table_name, *column_names, type: nil, **options)
        column_names.each do |column_name|
          validate_remove_column(table_name, column_name)
        end
        super
      end

      def rename_column(table_name, column_name, new_column_name)
        validate_remove_column(table_name, column_name)
        super
      end

      alias_method :safer_remove_column, :remove_column
      alias_method :safer_remove_columns, :remove_columns
      alias_method :safer_rename_column, :rename_column
    else
      def safer_remove_column(table_name, column_name, type = nil, **options)
        validate_remove_column(table_name, column_name)
        remove_column(table_name, column_name, type, **options)
      end

      def safer_remove_columns(table_name, *column_names, type: nil, **options)
        column_names.each do |column_name|
          validate_remove_column(table_name, column_name)
        end

        remove_columns(table_name, *column_names, type: type, **options)
      end

      def safer_rename_column(table_name, column_name, new_column_name)
        validate_remove_column(table_name, column_name)
        rename_column(table_name, column_name, new_column_name)
      end
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
