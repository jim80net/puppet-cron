# Class: cron::install
#
# This class ensures that the distro-appropriate cron package is installed
# 
# Parameters:
# 
# Actions:
# 
# Requires:
# 
# Sample Usage:
#   This class should not be used directly under normal circumstances
#   Instead, use the *cron* class.

class cron::install {
  case $operatingsystem  {
    /(RedHat|CentOS|OracleLinux)/:  {
        $package_name = $::lsbmajdistrelease ? {
           '5'     =>  'vixie-cron',
           default =>  'cronie',
        }
    }

    default: { $package_name =  'cron' } 
  }

  package {
    'cron':
      ensure => installed,
      name   => $package_name;
  }

  $service_name= $operatingsystem ? {
    /(RedHat|CentOS|OracleLinux)/ => 'crond',
    default                       => 'cron',
  }

  service {
  	'cron':
		ensure => running,
		name   => $service_name;
  }

}

