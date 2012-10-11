
include_recipe "nginx"
include_recipe "application_ruby"
include_recipe "mongodb::10gen"
include_recipe "mongodb::default"

mongodb_instance node['grubhaus']['db']['name'] do
    port node['grubhaus']['db']['port']
end

application "grubhaus" do
  path node['grubhaus']['path']

  rails do
  end

  unicorn do 
  end
end
