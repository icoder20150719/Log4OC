Pod::Spec.new do |s|

  s.name         = "Log4OC"
  s.version      = "0.0.1"
  s.summary      = "a log tool for iOS developer "

  s.description  = "Log4OC description"
  s.homepage     = "https://github.com/icoder20150719/Log4OC"
  s.license      = "MIT"
  s.author       = { "xiongan" => "andybbear@163.com" }
  s.platform     = :ios,'6.0'

  s.source       = { :git => "https://github.com/icoder20150719/Log4OC.git", :tag => "#{s.version}" }
  s.source_files = "LOGDemo/Classes/*.{h,m}"
  s.framework    = "UIKit"
  s.requires_arc = true
end

