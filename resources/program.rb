actions :create, :start, :stop, :restart, :remove

default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :command, :kind_of => String, :required => true

attribute :autostart, :kind_of => [FalseClass, TrueClass], :default => false
attribute :autorestart, :kind_of => [FalseClass, TrueClass], :default => false
attribute :update, :equal_to => [:immediate, :immediately, :delayed, :no_update], :default => :immediately
attribute :startretries, :kind_of => Integer
attribute :startsecs, :kind_of => Integer
attribute :user, :kind_of => String
attribute :directory, :kind_of => String
attribute :priority, :kind_of => Integer

attribute :redirect_stderr, :kind_of => [FalseClass, TrueClass, NilClass]
attribute :stdout_logfile, :kind_of => String
attribute :stdout_logfile_maxbytes, :kind_of => String
attribute :stderr_logfile, :kind_of => String
attribute :stderr_logfile_maxbytes, :kind_of => String

attribute :stopsignal, :equal_to => ["TERM", "HUP", "INT", "QUIT", "KILL", "USR1", "USR2"]

attribute :environment, :kind_of => Hash, :default => []

# private
attribute :service
