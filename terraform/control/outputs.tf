output "ip_addresses" {
  value = <<CONFIGURATION

Server IPs:
${module.hashistack_cluster.server_addresses}


To connect, add your private key and SSH into any client or server with
`ssh ubuntu@PUBLIC_IP`. You can test the integrity of the cluster by running:

  $ consul members
  $ nomad server members
  $ nomad node status

The Nomad UI can be accessed at ${module.hashistack_cluster.nomad_addr}/ui
The Consul UI can be accessed at ${module.hashistack_cluster.consul_addr}/ui

The Fabio UI can be accessed at ${module.hashistack_cluster.fabio_addr}

The Demo Web Application cna be accessed at http://${var.webapp_dnsname}

CLI environment variables:
export NOMAD_CLIENT_DNS=http://${module.hashistack_cluster.client_elb_dns}
export NOMAD_ADDR=${module.hashistack_cluster.nomad_addr}
export CONSUL_HTTP_ADDR=${module.hashistack_cluster.consul_addr}

CONFIGURATION
}
