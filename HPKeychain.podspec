Pod::Spec.new do |s|

  s.name         = "HPKeychain"
  s.version      = "0.0.1"
  s.summary      = "A lightweight but customisable networking stack written in Swift"

  s.homepage     = "https://panhans.dev/opensource/hpkeychain"

  s.license      = "MIT"

  s.author             = { "Henrik Panhans" => "henrik@panhans.dev" }
  s.social_media_url   = "https://twitter.com/henrik_dmg"

  s.ios.deployment_target = "12.0"
  s.osx.deployment_target = "10.11"
  s.watchos.deployment_target = "5.0"
  s.tvos.deployment_target = "12.0"

  s.source       = { :git => "https://github.com/henrik-dmg/HPKeychain.git", :tag => s.version }
  s.source_files  = "Sources/HPKeychain/**/*.swift"
  s.framework = "Foundation"
  s.swift_version = "5.1"

end

