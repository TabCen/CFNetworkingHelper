#
# Be sure to run `pod lib lint CFNetworkingHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CFNetworkingHelper'
  s.version          = '0.1.0'
  s.summary          = 'AFN网络请求库，简单封装类，用于简单的网络请求'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'AFN网络请求库，简单封装类，用于简单的网络请求'

  s.homepage         = 'https://github.com/TabCen/CFNetworkingHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenfeigogo@gmail.com' => '964267617@qq.com' }
  s.source           = { :git => 'https://github.com/TabCen/CFNetworkingHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CFNetworkingHelper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CFNetworkingHelper' => ['CFNetworkingHelper/Assets/*.png']
  # }

s.public_header_files = 'Pod/Classes/CFNetworkingHelper.h'
  # s.frameworks = 'UIKit', 'MapKit'

s.dependency 'AFNetworking', '~> 3.2.1'
s.dependency 'MBProgressHUD', '~> 1.1.0'

end
