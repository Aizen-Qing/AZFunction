Pod::Spec.new do |s|

  s.name         = "AZFunction"
  s.version      = "1.0.7"
  s.summary      = "AZFunction is help function"
  s.description  = <<-DESC
			AZFunction is aizen's help function.
                   DESC
  s.homepage     = "https://github.com/Aizen-Qing/AZFunction"
  s.license      = "MIT"
  s.author             = { "Aizen" => "845283394@qq.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Aizen-Qing/AZFunction.git", :tag => "#{s.version}" }
  s.source_files  = "AZFunction"

end
