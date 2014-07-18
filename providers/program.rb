use_inline_resources

def whyrun_supported?
  true
end

action :create do
  supervisord_update

  template "/etc/supervisor/conf.d/#{new_resource.name}.conf" do
    source 'supervised-program.conf.erb'
    cookbook 'supervisord'
    owner 'root'
    group 'root'
    mode '0644'
    variables :program => new_resource
    notifies :run, 'execute[supervisorctl update]', :immediately
  end

  s = service "supervisord_program_#{new_resource.name}" do
    start_command "supervisorctl start #{new_resource.name} | egrep -qv '(no such process|no such file)'"
    stop_command "supervisorctl stop #{new_resource.name}"
    restart_command "supervisorctl restart #{new_resource.name}"
    status_command "supervisorctl status #{new_resource.name} | egrep -q '(STARTING|RUNNING)'"
  end
  new_resource.service(s)
end

[:start, :stop, :restart].each do |a|
  action a do
    ruby_block "reload client config" do
      block do
        new_resource.service.run_action(a)
      end
      not_if "supervisorctl status #{new_resource.name} | egrep -q '(STARTING|RUNNING)'"
    end
  end
end

action :remove do
  supervisord_update

  file "/etc/supervisor/conf.d/#{new_resource.name}.conf" do
    action :delete
    notifies :run, 'execute[supervisorctl update]', :immediately
  end
end

def supervisord_update
  execute 'supervisorctl update' do
    action :nothing
    user 'root'
  end
end
