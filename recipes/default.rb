package "supervisor"

service "supervisor" do
  action [:enable,:start]
  reload_command "supervisorctl update"
end
