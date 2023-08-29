# frozen_string_literal: true

module ActiveRecord
  class SchemaMigration

    def create_table
    end
  end
end



# frozen_string_literal: true

require "benchmark"
require "set"
require "zlib"
require "active_support/core_ext/array/access"
require "active_support/core_ext/enumerable"
require "active_support/core_ext/module/attribute_accessors"
require "active_support/actionable_error"

module ActiveRecord
  class Migrator # :nodoc:
    class << self

      def current_version
        0
      end
    end

    self.migrations_paths = ["db/migrate"]

    def initialize(direction, migrations, schema_migration, internal_metadata, target_version = nil)
      @direction         = direction
      @target_version    = target_version
      @migrated_versions = nil
      @migrations        = migrations
      @schema_migration  = schema_migration
      @internal_metadata = internal_metadata
    end

    def current_version
      0
    end

    def current_migration
      nil
    end
    alias :current :current_migration

    def run
    end

    def migrate
    end

    def runnable
    end

    def migrations
    end

    def pending_migrations
    end

    def migrated
    end

    def load_migrated
    end
  end
end
