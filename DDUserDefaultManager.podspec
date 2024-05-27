Pod::Spec.new do |s|
s.name = 'DDUserDefaultManager'
s.swift_version = '5.0'
s.version = '2.0.1'
s.license= { :type => "MIT", :file => "LICENSE" }
s.summary = 'iOS UserDefault data management, iOS UserDefault数据管理'
s.homepage = 'https://github.com/DamonHu/DDUserDefaultManager'
s.authors = { 'DDKitCode' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/DamonHu/DDUserDefaultManager.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '11.0'
s.subspec 'core' do |cs|
	cs.resource_bundles = {
      'DDUserDefaultManager' => ['pod/assets/**/*']
    }
    cs.source_files = "pod/*.swift", "pod/view/*.swift", "pod/vc/*.swift", "pod/model/*.swift"
    cs.dependency 'DDKitUtil', '~>4.0'
    cs.dependency 'SnapKit'
end
s.default_subspecs = "core"
s.documentation_url = 'https://blog.hudongdong.com/ios/1169.html'
end
