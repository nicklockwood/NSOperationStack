
Pod::Spec.new do |s|
  s.name = 'NSOperationStack'
  s.version = '1.0.2'
  s.license = { :type => 'zlib', :file => 'LICENCE.md' }
  s.summary = "A powerful tool for creating FIFO (First In, First Out) queues of background tasks."
  s.homepage = "https://github.com/nicklockwood/NSOperationStack"
  s.authors = { "Nick Lockwood" => "support@charcoaldesign.co.uk" } 
  s.source = { :git => 'https://github.com/nicklockwood/NSOperationStack.git', :tag => '1.0.2' }
  s.social_media_url = "https://twitter.com/nicklockwood"
  s.ios.deployment_target = '4.0'
  s.osx.deployment_target = '10.6'
  s.source_files  = 'NSOperationStack'
  s.framework = 'Foundation'
end