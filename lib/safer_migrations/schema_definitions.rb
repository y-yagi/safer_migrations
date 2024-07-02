# frozen_string_literal: true

module SaferMigrations
  module TableDefinition
    def safer_remove(*column_names, **options)
      column_names.each do |column_name|
        validate_remove_column(column_name)
      end
      remove(*column_names, **options)
    end

    private

    def validate_remove_column(column_name)
      if model.column_names.include?(column_name.to_s)
        raise SaferMigrations::DangerousMigrationError, "'#{model}' model still uses '#{column_name}'"
      end
    end

    def model
      @model ||= @name.to_s.classify.constantize
    end
  end
end
