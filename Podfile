# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

flutter_application_path = '../io_flutter'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'io' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for io
  pod 'AEOTPTextField'
  
  # backport to use new api
  pod 'DiffableDataSources'
  pod 'IBPCollectionViewCompositionalLayout'

  install_all_flutter_pods(flutter_application_path)
end

post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
