
Pod::Spec.new do |s|
  s.name             = 'FilteredString'
  s.version          = '0.0.1'
  s.summary          = 'A short description of FilteredString.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Decybel07/FilteredString'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Adrian Bobrowski' => 'adrian071993@gmail.com' }
  s.source           = { :git => "https://github.com/Decybel07/FilteredString.git", :tag => s.version }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Source/**/*.swift'
  s.frameworks = 'Foundation'
end
