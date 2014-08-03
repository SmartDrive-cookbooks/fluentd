#
# Cookbook Name:: fluentd
# Recipe:: default
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

# rbenv install
include_recipe "ruby_build"
include_recipe "rbenv::system"

rbv = node["fluentd"]["ruby"]["version"]

rbenv_ruby rbv
rbenv_global rbv

# fluentd install
rbenv_gem "fluentd" do
	rbenv_version   node["fluentd"]["version"] if node["fluentd"]["pinning_version"]
	version node["fluentd"]["version"] if node["fluentd"]["pinning_version"]
    action :install
    options node["fluetnd"]["options"] if node["fluentd"]["options"]
end

node["fluentd"]["plugins"].each do |plugin|
	if plugin.is_a?(Hash)
    	rbenv_gem plugin["name"] do
    	    %w{action version options source}.each do |attr|
    	        send(attr, plugin[attr]) if plugin[attr]
    	    end
    	end
	elsif plugin.is_a?(String)
		rbenv_gem plugin
	end
end

include_recipe "fluentd::config"
