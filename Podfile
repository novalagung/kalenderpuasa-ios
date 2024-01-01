# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'Kalender Puasa' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Kalender Puasa
  pod 'NVDate', '1.0.0'
  pod 'FirebaseAnalytics', '~> 10.2'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "11.0"
      end
    end
  end
end
