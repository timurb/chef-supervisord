action :supervise do
  template "/etc/supervisor/conf.d/#{new_resource.name}.conf" do
    source "supervised-program.conf.erb"
    cookbook "supervisord"
    owner "root"
    group "root"
    mode "0644"
    variables :program => new_resource
    notifies :reload, "service[supervisor]"
  end

  s = service "supervisord_program_#{new_resource.name}" do
    start_command "supervisorctl start #{new_resource.name} | grep -qv 'no such file'"
    stop_command "supervisorctl stop #{new_resource.name}"
    restart_command "supervisorctl restart #{new_resource.name}"
    status_command "supervisorctl status #{new_resource.name} | egrep -q '(STARTING|RUNNING)'"
  end
  new_resource.service(s)
end

[:start, :stop, :restart].each do |a|
  action a do
    new_resource.service.run_action(a)
  end
end

action :remove do
  file "/etc/supervisor/conf.d/#{new_resource.name}.conf" do
    action :delete
    notifies :reload, "service[supervisor]"
  end
end
