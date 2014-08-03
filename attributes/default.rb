
default["fluentd"]["pinning_version"] = false
default["fluentd"]["version"] = '0.10.49'
default["fluentd"]["options"] = nil

default["fluentd"]["plugins"] = []

default["fluentd"]["includes"] = false
default["fluentd"]["default_config"] = true 
default["fluentd"]["directory"]["config"] = "/etc/fluent"
default["fluentd"]["directory"]["include"] = "/etc/fluent/conf.d"
default["fluentd"]["directory"]["log"] = "/var/log/fluentd"

default["fluentd"]["ruby"]["version"] = "2.1.2"
default["fluentd"]["ruby"]["bin"] = "/usr/local/rbenv/versions/#{node["fluentd"]["ruby"]["version"]}/bin"
