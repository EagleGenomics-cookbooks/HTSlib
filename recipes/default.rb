#
# Cookbook Name:: HTSlib
# Recipe:: default
#
# Copyright (c) 2016 Eagle Genomics Ltd, Apache License, Version 2.0.

package ['tar', 'zlib-devel'] do
  action :install
end

include_recipe 'build-essential'

# here for use by serverspec
magic_shell_environment 'htslib_DIR' do
  value node['htslib']['dir']
end

magic_shell_environment 'htslib_VERSION' do
  value node['htslib']['version']
end

magic_shell_environment 'htslib_INSTALL' do
  value node['htslib']['install_path']
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['htslib']['filename']}" do
  source node['htslib']['url']
  action :create_if_missing
end

execute 'un-tar htslib' do
  command "tar xjf #{Chef::Config[:file_cache_path]}/#{node['htslib']['filename']} -C #{node['htslib']['install_path']}"
  not_if { ::File.exist?("#{node['htslib']['dir']}/htslib") }
end

bash 'install htslib' do
  cwd node['htslib']['dir']
  code <<-EOH
    ./configure
    make
    make install
  EOH
  not_if { ::File.exist?("#{node['htslib']['dir']}/htsfile") }
end

# this symlinks every executable in the install subdirectory to the top of the directory tree
# so that they are in the PATH
execute "find #{node['htslib']['dir']} -maxdepth 1 -name 'htslib' -executable -type f -exec ln -sf {} . \\;" do
  cwd node['htslib']['install_path'] + '/bin'
end
