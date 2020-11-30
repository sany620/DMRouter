#
# Be sure to run `pod lib lint DMRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DMRouter'
  s.version          = '1.1.3'
  s.summary          = 'iOS路由.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/sany620/DMRouter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'duanmu' => 'ahwtquanqinyang@126.com' }
  s.source           = { :git => 'https://github.com/sany620/DMRouter.git', :tag => 'v1.1.3' }
  # s.social_media_url = 'https://blog.csdn.net/quanqinyang'

  s.ios.deployment_target = '9.0'

  s.source_files = 'DMRouter/Classes/**/*'

  # s.resource_bundles = {
  #   'DMRouter' => ['DMRouter/Assets/*.png']
  # }

  # s.public_header_files = 'DMRouter/Classes/*.{h,m}'
  # s.frameworks = 'UIKit','Foundation'
end
