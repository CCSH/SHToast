Pod::Spec.new do |s|

    s.name         = "SHToast"
    s.version      = "1.0.3"
    s.summary      = "Toast弹框+推送"
    s.homepage     = "https://github.com/CCSH/SHToast"
    s.license      = "MIT"
    s.authors      = { "CSH" => "624089195@qq.com" }
    s.platform     = :ios, "6.0"
    s.source       = { :git => "https://github.com/CCSH/SHToast.git", :tag => s.version }
    s.source_files = "SHToast/*.{h,m}"
    s.requires_arc = true

end
