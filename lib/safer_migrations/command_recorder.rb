# frozen_string_literal: true

module SaferMigrations
  module CommandRecorder
    ruby2_keywords def safer_remove_column(*args, &block)
      record(:safer_remove_column, args, &block)
    end

    def invert_safer_remove_column(args)
      invert_remove_column(args)
    end

    ruby2_keywords def safer_remove_columns(*args, &block)
      record(:safer_remove_columns, args, &block)
    end

    def invert_safer_remove_columns(args)
      invert_remove_columns(args)
    end
  end
end
