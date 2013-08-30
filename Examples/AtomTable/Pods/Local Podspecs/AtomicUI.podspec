Pod::Spec.new do |s|
  s.name     = 'AtomicUI'
  s.version  = '1.0.4'
  s.license  = 'MIT'
  s.summary  = 'AtomicUI provides easy to use interfaces elements in order to make the creation of mockups and simple applications fast and easy.'
  s.homepage = 'https://code.kahdu.org/brian-s-projects/atomicui.git'
  s.authors  = {'Brian Thomas' => 'brian@wideeyelabs.com'}
  s.source   = { :git => 'https://code.kahdu.org/brian-s-projects/atomicui.git', :tag => '1.0.4'}
  s.source_files = 'AtomicUI', 'AtomicUI/AtomicSlide', 'AtomicUI/AtomicTable'
  s.requires_arc = true
  s.dependency 'Masonry'

  s.ios.deployment_target = '6.0'
end
