# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hashtostruct}
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Timothy Caraballo"]
  s.date = %q{2008-11-25}
  s.description = %q{Takes a Hash and converts it into a Struct with each key as a property and each value converted into a native object if possible.}
  s.email = ["openback@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "lib/hashtostruct.rb", "script/console", "script/destroy", "script/generate", "spec/hashtostruct_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/openback/hashtostruct/tree/master}
  s.rdoc_options = ["--main", "README.rdoc~"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{hashtostruct}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Takes a Hash and converts it into a Struct with each key as a property and each value converted into a native object if possible.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.1.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
