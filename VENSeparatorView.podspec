Pod::Spec.new do |s|
  s.name         = 'VENSeparatorView'
  s.version      = '0.0.1'
  s.summary      = 'Separator view used in the Venmo app.'
  s.description   = <<-DESC
                   An easy to use separator view that is used in the Venmo app.
                   DESC
  s.homepage     = 'https://github.com/venmo/VENTokenField'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Venmo' => 'ios@venmo.com'}
  s.source       = { :git => 'git@github.com:venmo/VENTokenField.git', :tag => "v#{s.version}"}
  s.source_files = 'VENSeparatorView/*.{h,m}'
  s.dependency 'ColorUtils', '~> 1.1.2'
  s.platform     = :ios, '6.0'
  s.requires_arc = true
end