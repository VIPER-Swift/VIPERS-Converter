Pod::Spec.new do |s|
  s.name             = "VIPERS-Converter"
  s.version          = "0.1.0"
s.summary          = "Converter implementation used by the iOS application framework 'VIPERS'"

  s.description      = <<-DESC
                        Converter implementation used by the iOS application framework 'VIPERS'
                        A converter is an object responsible to convert one element into an other element.
                       DESC

  s.homepage         = "https://github.com/VIPER-Swift/VIPERS-Converter"
  s.license          = 'MIT'
  s.author           = { "Jan Bartel" => "barteljan@yahoo.de" }
  s.source           = { :git => "https://github.com/VIPER-Swift/VIPERS-Converter.git", :tag => s.version.to_s }
  
  s.ios.deployment_target = '8.0'

  s.source_files = 'Pod/Classes/**/*'

  s.dependency 'VIPERS-Converter-Protocol'
end
