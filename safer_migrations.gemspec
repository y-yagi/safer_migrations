# frozen_string_literal: true

require_relative "lib/safer_migrations/version"

Gem::Specification.new do |spec|
  spec.name = "safer_migrations"
  spec.version = SaferMigrations::VERSION
  spec.authors = ["Yuji yaginuma"]
  spec.email = ["yuuji.yaginuma@gmail.com"]

  spec.summary = "Provide safer migration methods"
  spec.homepage = "https://github.com/y-yagi/safer_migrations"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ gemfiles/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 6.1"
  spec.add_dependency "activerecord", ">= 6.1"
end
