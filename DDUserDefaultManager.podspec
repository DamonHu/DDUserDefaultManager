Pod::Spec.new do |s|
s.name = 'DDUserDefaultManager'
s.swift_version = '5.0'
s.version = '3.0.2'
s.license= { :type => "MIT", :file => "LICENSE" }
s.summary = 'iOS UserDefault data management, iOS UserDefault数据管理'
s.homepage = 'https://github.com/DamonHu/DDUserDefaultManager'
s.authors = { 'DamonHu' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/DamonHu/DDUserDefaultManager.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '12.0'
s.subspec 'core' do |cs|
	cs.resource_bundles = {
      'DDUserDefaultManager' => ['pod/assets/**/*']
    }
    cs.source_files = "pod/*.swift", "pod/view/*.swift", "pod/vc/*.swift", "pod/model/*.swift"
    cs.dependency 'DDUtils/ui'
    cs.dependency 'SnapKit'
end
s.default_subspecs = "core"
s.documentation_url = 'https://dongge.org/blog/1289.html'
end
