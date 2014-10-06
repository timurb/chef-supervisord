use_inline_resources

def whyrun_supported?
  true
end

action :create do
  supervisord_update

  template "/etc/supervisor/conf.d/group_#{new_resource.name}.conf" do
    source 'supervised-group.conf.erb'
    cookbook 'supervisord'
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      :group => new_resource.name,
      :programs => new_resource.programs.join(",")
    )
    notifies :run, 'execute[supervisorctl update]', new_resource.update unless new_resource.update == :no_update
  end
end

action :remove do
  supervisord_update

  file "/etc/supervisor/conf.d/group_#{new_resource.name}.conf" do
    action :delete
    notifies :run, 'execute[supervisorctl update]', new_resource.update unless new_resource.update == :no_update
  end
end

def supervisord_update
  execute 'supervisorctl update' do
    action :nothing
    user 'root'
  end
end
