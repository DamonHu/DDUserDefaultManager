Pod::Spec.new do |s|
s.name = 'ZXUserDefaultManager'
s.swift_version = '5.0'
s.version = '0.0.2'
s.license= { :type => "Apache-2.0", :file => "LICENSE" }
s.summary = 'iOS UserDefault data management, iOS UserDefault数据管理'
s.homepage = 'https://github.com/ZXKitCode/ZXUserDefaultManager'
s.authors = { 'ZXKitCode' => 'dong765@qq.com' }
s.source = { :git => "https://github.com/ZXKitCode/ZXUserDefaultManager.git", :tag => s.version}
s.requires_arc = true
s.ios.deployment_target = '11.0'
s.subspec 'core' do |cs|
	cs.resource_bundles = {
      'ZXUserDefaultManager' => ['pod/assets/**/*']
    }
    cs.source_files = "pod/*.swift", "pod/view/*.swift", "pod/vc/*.swift", "pod/model/*.swift"
    cs.dependency 'ZXKitUtil'
    cs.dependency 'SnapKit'
end
s.subspec 'zxkit' do |cs|
    cs.dependency 'ZXUserDefaultManager/core'
    cs.dependency 'ZXKitCore/core'
    cs.source_files = "pod/zxkit/*.swift"
end
s.default_subspecs = "core"
s.documentation_url = 'https://blog.hudongdong.com/ios/1169.html'
end
