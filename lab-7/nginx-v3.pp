$app= "nginx"
$version= "v3"
$content= "Welcome to $app-$version.pp By Maximilien on puppet server"

package { $app:
  ensure => 'present',
}

service { $app:
  ensure    => 'running',
  enable    => 'true',
  #nginx redemarre que si exécution de package ou de file
  subscribe => [
    Package[$app],
    File['/usr/share/nginx/html/index.html'],
  ],
}

#eventuelement file notifie le service nginx,
file { '/usr/share/nginx/html/index.html':
  content => "$content",
  notify => Service[$app],
}
