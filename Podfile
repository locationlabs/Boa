source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

# flag makes all dependencies build as frameworks
use_frameworks!


target 'Boa' do
   # framework dependencies
   pod 'Swinject', '~> 2.0.0-beta.2'
   pod 'SwinjectStoryboard', '1.0.0-beta.2'
   pod 'Cobra', :path => '../Cobra'
   pod 'Medusa', :path => '../Medusa'
   pod 'PromiseKit/CorePromise', '~> 4.0'
end

post_install do |installer|

    installer.pods_project.targets.each do |target|
       target.build_configurations.each do |config|
         config.build_settings['SWIFT_VERSION'] = '3.0'
       end
    end
end
