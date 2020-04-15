Pod::Spec.new do |s|
  s.name          = "FlowKit"
  s.version       = "0.0.2"
  s.summary       = "Provides base structure for navigation and combining screens together."
  s.license       = { }
  s.homepage      = "https://github.com/214alphadev/flowkit"
  s.author        = { "Andrii Selivanov" => "seland@214alpha.com" }
  s.platform      = :ios, "11.0"
  s.source        = { :git => "git@github.com:214alphadev/flowkit.git" }
  s.source_files  = "FlowKit/**/*.swift"
  s.framework     = "UIKit"
end
