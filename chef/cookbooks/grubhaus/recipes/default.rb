
include_recipe "nginx"
include_recipe "mongodb::10gen_repo"
include_recipe "nodejs"
include_recipe "nodejs::dev"
include_recipe "nodejs::npm"

mongodb_instance node['grubhaus']['db']['name'] do
    port node['grubhaus']['db']['port']
end

%w(zlib1g-dev openssl libopenssl-ruby1.9.1 libssl-dev libruby1.9.1\ 
   libreadline-dev git-core).each { |pkg| 
  package pkg
}

directory node['rbenv']['dir'] do
  mode 0777
end

bash "install rbenv" do
  code <<-EOH
    git clone #{node['rbenv']['url']} #{node['rbenv']['dir']}
  EOH
  not_if { Dir.entries(node['rbenv']['dir']).size > 2 }
end

bash "set rbenv path" do
  user node['user']
  code <<-EOH
    echo 'export PATH="#{node['rbenv']['dir']}/bin:$PATH"' >> #{node['grubhaus']['home']}/.bashrc
    echo 'eval "$(rbenv init -)"' >> #{node['grubhaus']['home']}/.bashrc
    exec $SHELL
  EOH
  not_if { %x[cat #{node['rbenv']['dir']}/version].include? node['ruby']['version'] }
end

directory "#{node['rbenv']['dir']}/plugins" do
  action :create
end

bash "install ruby_build" do
  cwd "#{node['rbenv']['dir']}/plugins"
  code <<-EOH
    git clone #{node['ruby_build']['url']}
  EOH
  not_if { ::File.directory? "#{node['rbenv']['dir']}/plugins/ruby-build" }
end

bash "install ruby" do
  user node['user']
  code <<-EOH
    export RBENV_ROOT=#{node['rbenv']['dir']}
    #{node['rbenv']['dir']}/bin/rbenv install #{node['ruby']['version']}
    #{node['rbenv']['dir']}/bin/rbenv rehash
    #{node['rbenv']['dir']}/bin/rbenv global #{node['ruby']['version']}
  EOH
  not_if { %x[cat #{node['rbenv']['dir']}/version].include? node['ruby']['version'] }
end

