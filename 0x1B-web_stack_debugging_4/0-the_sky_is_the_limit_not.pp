# Puppet manifest to address the problem of high amount of requests
#
# Problem:
#   The current configuration of Nginx limits the maximum number of open file descriptors (ULIMIT) to 15.
#   This low limit may cause Nginx to fail under high load or prevent it from handling a large number of concurrent connections efficiently.
#
# Solution:
#   1. Use the 'sed' command to replace the ULIMIT value in the Nginx configuration file (/etc/default/nginx) with a higher value (4096).
#   2. Restart the Nginx service to apply the new configuration.
#
# Note:
#   - This Puppet script assumes that the 'sudo' command is available
#   for the Puppet user and that it can run commands with elevated privileges.
#   - Ensure that the 'sudo' configuration allows the Puppet user to execute the necessary commands without requiring a password.
#   - Verify that modifying the ULIMIT value is appropriate for your system's requirements and resources.
#   - This script should be run with caution, especially in production environments,
#    as it directly modifies system configuration files and restarts services.

# Exec resource to replace the ULIMIT value in the Nginx configuration file
exec {'replace_ulimit':
  provider => shell,
  command  => 'sudo sed -i "s/ULIMIT=\"-n 15\"/ULIMIT=\"-n 4096\"/" /etc/default/nginx',
  before   => Exec['restart_nginx'], # Ensure this command runs before restarting Nginx
}

# Exec resource to restart the Nginx service
exec {'restart_nginx':
  provider => shell,
  command  => 'sudo service nginx restart',
}
