#
# Cookbook Name:: fluentd
# Recipe:: default
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

fluentd_dir = node["fluentd"]["directory"]

# setup directories and scripts
%w{ config include log }.each do |dir|
  directory fluentd_dir[dir] do
	  action :create
  end
end

if node["fluentd"]["includes"]
	directory fluentd_dir["include"] do
		action :create
	end
end

# setup directories and scripts
template "#{fluentd_dir["config"]}/fluentd.conf" do
    owner "root"
    group "root"
    mode 00755
    source "fluentd.conf.erb"
	variables ({
		:include_flag => node["fluentd"]["includes"],
		:default_flag => node["fluentd"]["default_config"]
	})
end

template "/etc/init.d/fluentd" do
	owner "root"
	group "root"
	mode 00755
	source "#{node["platform_family"]}/fluentd.erb"
	variables ({
		:conf_dir => fluentd_dir["config"],
		:log_dir => fluentd_dir["log"],
    :bin_dir => node["fluentd"]["ruby"]["bin"]
	})
end

service "fluentd" do
	action [ :enable, :start ]
end
