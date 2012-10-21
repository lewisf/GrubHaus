
# Nginx config
normal['nginx']['default_site_enabled'] = false
normal['nginx']['install_method'] = 'source'

normal[:mongodb][:dbpath] = "/data/db"
default['ruby']['version'] = "1.9.3-p194"

default['rbenv']['url'] = "git://github.com/sstephenson/rbenv.git"

default['ruby_build']['url'] = "git://github.com/sstephenson/ruby-build.git"
