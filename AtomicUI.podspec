Pod::Spec.new do |s|
  s.name     = 'AtomicUI'
  s.version  = '1.0.1'
  s.license  = 'MIT'
  s.summary  = 'AtomicUI provides easy to use interfaces elements in order to make the creation of mockups and simple applications fast and easy.'
  s.homepage = 'https://github.com/WideEyeLabs/AtomicUI'
  s.authors  = {'Brian Thomas' => 'brian@wideeyelabs.com'}
  s.source   = { :git => 'https://github.com/WideEyeLabs/AtomicUI.git', :tag => '1.0.1'}
  s.source_files = 'AtomicUI', 'AtomicUI/AtomicSlide', 'AtomicUI/AtomicTable', 'AtomicUI/AtomicPullOver'
  s.requires_arc = true
  s.dependency 'Masonry', '0.2.3'

  s.ios.deployment_target = '6.0'
end
