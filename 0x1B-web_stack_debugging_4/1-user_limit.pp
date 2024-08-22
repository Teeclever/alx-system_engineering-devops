# Puppet manifest to address the problem of a high number of files opened
#
# Problem:
#   The default limits for the number of files opened (nofile) are set too low, 
#   which may lead to issues when the system needs to handle a large number of files concurrently.
#
# Solution:
#   1. Increase the 'nofile' limit in the '/etc/security/limits.conf' file to allow for a higher number of open files.
#
# Note:
#   - This Puppet script assumes that the 'sudo' command is available
#   for the Puppet user and that it can run commands with elevated privileges.
#   - Ensure that the 'sudo' configuration allows the Puppet user to execute the necessary commands without requiring a password.
#   - Verify that modifying the 'nofile' limits is appropriate for your system's requirements and resources.
#   - This script should be run with caution, especially in production environments, as it directly modifies system configuration files.

# Exec resource to replace the 'nofile' limit to 50,000 in the '/etc/security/limits.conf' file
exec {'replace_nofile_1':
  provider => shell,
  command  => 'sudo sed -i "s/nofile 5/nofile 50000/" /etc/security/limits.conf',
  before   => Exec['replace_nofile_2'], # Ensure this command runs before replacing the second 'nofile' limit
}

# Exec resource to replace the 'nofile' limit to 40,000 in the '/etc/security/limits.conf' file
exec {'replace_nofile_2':
  provider => shell,
  command  => 'sudo sed -i "s/nofile 4/nofile 40000/" /etc/security/limits.conf',
}
