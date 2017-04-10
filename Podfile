source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

# flag makes all dependencies build as frameworks
use_frameworks!

abstract_target 'BoaBase' do

   # framework dependencies
   pod 'Swinject', '2'
   pod 'SwinjectPropertyLoader', '1.0.0'
   pod 'SwinjectStoryboard', '1.0.0'
   pod 'Cobra', '3.0.0'
   pod 'Gorgon', '3.0.0'
   pod 'PromiseKit/CorePromise', '4.1.0'
   target 'Boa' do
   end
end


post_install do |installer|
   installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
         config.build_settings['SWIFT_VERSION'] = '3.0'
      end
   end
end

