job "fabio" {
  datacenters = ["dc1"]
  type = "system"

  group "fabio" {
    count = 1
    network {
      port "http" {
        static = 9999
      }
      port "admin" {
        static = 9998
      }
    }
    task "fabio" {
      driver = "docker"
      config {
        image        = "fabiolb/fabio"
        network_mode = "host"
        ports        = ["http","admin"]
      }

      resources {
        cpu    = 100 
        memory = 128 

      }
    }
  }
}
