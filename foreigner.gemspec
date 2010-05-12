# -*- encoding: utf-8 -*-
 
Gem::Specification.new do |s|
  s.name = 'marnen-foreigner'
  s.version = '0.9.2'
  s.summary = 'Foreign keys for Rails'
  s.description = 'Adds helpers to migrations and correctly dumps foreign keys to schema.rb. Forked from marnen-foreigner.'
  
  s.required_ruby_version     = '>= 1.8.7'
  s.required_rubygems_version = '>= 1.3.6'

  s.author            = 'Marnen Laibow-Koser'
  s.email             = 'marnen@marnen.org'
  s.homepage          = 'http://github.com/marnen/foreigner'
  
  s.extra_rdoc_files = %w(README.rdoc)
  s.files = %w(MIT-LICENSE Rakefile README.rdoc) + Dir['lib/**/*.rb'] + Dir['test/**/*.rb']
  s.add_dependency('activerecord', '>= 3.0.0')
  s.require_paths = %w(lib)  
end