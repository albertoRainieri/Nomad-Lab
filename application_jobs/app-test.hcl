job "nprod-rundeck-test" {
  region      = "global"
  datacenters = ["dc1"]
  type        = "service"

  update {
    min_healthy_time  = "15s"
    healthy_deadline  = "15m"
    progress_deadline = "30m"
    health_check      = "checks"
    auto_revert       = true
    max_parallel      = 1
  }

  group "nprod-rundeck-test" {
    count = 1

    vault {
      use_workload_identity = true
      role = "nomad-cluster"
    }

    constraint {
      attribute = "${node.unique.name}"
      operator  = "="
      value     = "vagrant"
    }

    # Removed network block - no ports needed for BusyBox test
    
    task "nprod-rundeck-test" {
      driver = "docker"

      identity {
        aud = ["vault"]
        file = true
      }

      env {
      }

      config {
        image = "busybox:1.36"
        force_pull = "true"
        command = "sh"
        args    = ["-c", "echo SECRET_KEY=$SECRET_KEY; echo '--- rendered file ---'; cat ${NOMAD_SECRETS_DIR}/env.vars; sleep 3600"]
        #ports configuration is part of dynamic port mapping to 4440.
        #ports = ["http"]
      }

      template {
        destination = "${NOMAD_SECRETS_DIR}/env.vars"
        env         = true
        change_mode = "noop"
        data        = <<EOH
  {{ with secret "secret/data/test/secret-key" }}
  SECRET_KEY={{ index .Data.data "secret-key" }}
  {{ end }}
        EOH
      }

      # Removed service block since BusyBox doesn't serve HTTP
      # and we don't need port mapping for this Vault test
    }
  }
}