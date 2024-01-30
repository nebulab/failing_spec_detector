lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'failing_spec_detector/version'

Gem::Specification.new do |spec|
  spec.name          = 'failing_spec_detector'
  spec.version       = FailingSpecDetector::VERSION
  spec.authors       = ['safa']
  spec.email         = ['aballaghsafa@gmail.com']

  spec.summary       = 'A tool to detect failing specs and group them by error message'
  spec.description   = <<~DESCRIPTION
    Automatic Failing spec detector.
    Introduces a custom rspec formatter to detect failing specs and group them by exception.
  DESCRIPTION
  spec.homepage      = 'https://github.com/nebulab/failing_spec_detector'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/nebulab/failing_spec_detector'
    # spec.metadata["changelog_uri"] = "https://github.com/nebulab/failing_spec_detector"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
          'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
