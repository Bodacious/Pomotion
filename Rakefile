# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
  load 'Rakefile_private'
rescue LoadError
end



Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Pomotion'
  app.version = app.short_version = '0.0.2'
  
  app.interface_orientations = [:portrait]
  app.device_family = :iphone
  
  app.pixatefreestyle.framework = 'vendor/PixateFreestyle.framework'
  app.vendor_project('vendor/NSDate+SecsIn25Mins', :static)
  
  app.icons = Dir["#{File.dirname(__FILE__)}/resources/Icon*"].map { |path| path.split('/Users/Gavin/Code/RayWenderlich/Pomotion1st/resources/').last }
  
  app.sdk_version = '8.1'
  app.deployment_target = '8.0'
  
end
task :"build:simulator" => :"schema:build"
