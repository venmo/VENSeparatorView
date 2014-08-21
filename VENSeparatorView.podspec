Pod::Spec.new do |s|
  s.name         = 'VENSeparatorView'
  s.version      = '1.0.1'
  s.summary      = 'Separator view used in the Venmo app.'
  s.description   = <<-DESC
                   An easy to use separator view that is used in the Venmo app.
                   DESC
  s.homepage     = 'https://www.github.com/venmo/VENSeparatorView'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Venmo' => 'ios@venmo.com'}
  s.source       = { :git => 'https://github.com/venmo/VENSeparatorView.git', :tag => "v#{s.version}"}
  s.source_files = 'VENSeparatorView/*.{h,m}'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
end