#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

docker_service 'default' do
  insecure_registry 'myregistry.com:5000'
  action [:create]
end
bash 'add_docker_option' do
  code <<-EOH
    echo '{"insecure-registries" : ["myregistry.com:5000"]}' > /etc/docker/daemon.json
    EOH
end
docker_service 'default' do
  action [:start]
end
