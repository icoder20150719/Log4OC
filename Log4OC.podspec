Pod::Spec.new do |s|

  s.name         = "Log4OC"
  s.version      = "0.0.2"
  s.summary      = "a log tool for iOS developer "

  s.description  =  "a log tool for iOS developer that can redirect to file and  rollback with file size, used as NSLog"
  s.homepage     = "https://github.com/icoder20150719/Log4OC"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "xiongan" => "andybbear@163.com" }
  s.platform     = :ios,'6.0'

  s.source       = { :git => "https://github.com/icoder20150719/Log4OC.git", :tag => "#{s.version}" }
  s.source_files = "LOGDemo/Classes/*.{h,m}"
  s.framework    = "UIKit"
  s.requires_arc = true
end

