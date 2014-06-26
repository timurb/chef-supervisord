package "supervisor"

service "supervisor" do
  action [:enable,:start]
  reload_command "supervisorctl update"
  status_command "/etc/init.d/supervisor status"
end
