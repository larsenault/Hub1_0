# Uncomment the next line to define a global platform for your project
# platform :ios, '14.0'

target 'Hub1.0' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Hub1.0

  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
 
  
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
  end

end
