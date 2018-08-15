#
#  Be sure to run `pod spec lint SHToast.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SHToast"
  s.version      = "1.0.0"
  s.summary      = "轻量级toast弹框"
  s.homepage     = "https://github.com/CCSH/SHToast/SHToast"
  s.license      = "MIT"
  s.authors      = { "CCSH" => "624089195@qq.com" }
  s.source       = { :git => "https://github.com/CCSH/SHToast/SHToast.git", :tag => "#{s.version}" }
  s.requires_arc = true
  s.ios.deployment_target = "7.0"
  s.source_files = "SHToast/*.{h,m}"

end
