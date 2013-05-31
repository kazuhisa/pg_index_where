# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pg_index_where/version'

Gem::Specification.new do |spec|
  spec.name          = 'pg_index_where'
  spec.version       = PgIndexWhere::VERSION
  spec.authors       = ['Yamamoto Kazuhisa']
  spec.email         = ['ak.hisashi@gmail.com']
  spec.description   = %q{pg_index_where will provide unique index with WHERE statement on PostgreSQL with migrate the database on Rails.}
  spec.summary       = %q{When create unique index on PostgreSQL, you can speficy WHERE statement as you know. pg_index_where will provide this function with migrate the database.}
  spec.homepage      = 'https://github.com/kazuhisa/pg_index_where'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.13'
  spec.add_development_dependency 'rails', '>= 3.0.7'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'acts_as_paranoid'
  spec.add_dependency 'pg', '~> 0.15'
  spec.add_dependency 'activerecord', '>= 3.0.7'
end
