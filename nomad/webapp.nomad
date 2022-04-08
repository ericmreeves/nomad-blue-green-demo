job "webapp" {

  datacenters = ["dc1"]
  type = "service"

  update {
    max_parallel = 1
    canary = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    auto_revert = true
    auto_promote     = false
  }

  group "webapp" {
    count = 5
    restart {
      # The number of attempts to run the job within the specified interval.
      attempts = 10
      interval = "5m"
      # The "delay" parameter specifies the duration to wait before restarting
      # a task after it has failed.
      delay = "30s"
      mode = "delay"
    }

    network {
      port "http" {
        to = 8080
      }
    }

    service {
      name = "webapp"
      tags = [ "urlprefix-/", "webapp"]
      port = "http"
      check {
        name     = "alive"
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "webapp" {
      driver = "docker"
      config {
        image = "ericreeves/webapp:1.0"
        ports = ["http"]
      }

      resources {
        cpu    = 100
        memory = 32
      }
    }
  }
}
