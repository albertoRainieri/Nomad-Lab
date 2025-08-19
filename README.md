# Nomad ARM64 Vagrant + Ansible Lab

Three-node infrastructure on Ubuntu 24.04 ARM64 using Vagrant and Ansible. Includes a Nomad cluster with Vault integration for secret management.

## Architecture
- **nserver** (192.168.59.110): Nomad server node
- **nclient1** (192.168.59.111): Nomad client node  
- **ninfra** (192.168.59.120): Infrastructure node running PostgreSQL and Vault

## Prerequisites
- Vagrant with VirtualBox or Libvirt provider
- Ansible

## Repository Structure
```
├── Vagrantfile                    # 3 VMs: nserver, nclient1, ninfra
├── hosts.yaml                     # Ansible inventory with all node groups
├── ansible.cfg                    # Ansible configuration
├── create-nomad-cluster.yaml      # Main orchestration playbook
├── playbook/
│   ├── vars.yaml                  # All configuration variables
│   ├── install-infra.yaml         # PostgreSQL & Vault setup
│   ├── install-nomad.yaml         # Nomad installation
│   ├── init-server.yaml           # Nomad server initialization
│   ├── join-client.yaml           # Nomad client configuration
│   └── verify-nomad.yaml          # Cluster verification
├── application_jobs/
│   └── app-test.hcl               # Sample Nomad job with Vault integration
├── vault_config/
│   ├── commands.txt               # Vault setup commands
│   └── nomad-cluster.hcl          # Vault configuration
├── logs/                          # Runtime logs
└── email/                         # Email configurations
```

## Features
- **Nomad v1.10.3** cluster with server/client architecture
- **Vault v1.19.5** integration with JWT authentication
- **Workload Identity** for secure secret access
- Docker driver support for containerized workloads
- Sample job demonstrating Vault secret injection

## Quick Start
1. **Start the infrastructure:**
   ```bash
   vagrant up
   ```

2. **Deploy the complete stack:**
   ```bash
   ansible-playbook create-nomad-cluster.yaml
   ```

3. **Access services:**
   - Nomad UI: http://192.168.59.110:4646
   - Vault UI: http://192.168.59.120:8200

4. **Test Vault integration:**
   ```bash
   nomad job run application_jobs/app-test.hcl
   ```

## Configuration
Key settings in `playbook/vars.yaml`:
- **Network IPs**: Server (110), Client (111), Infra (120)
- **Nomad version**: 1.10.3
- **Vault version**: 1.19.5
- **Region/Datacenter**: global/dc1

## Vault Integration
- JWT-based authentication between Nomad and Vault
- Workload Identity for secure secret access
- Sample secrets stored at `secret/data/test/secret-key`
- Automatic token rotation and management

## Sample Application
The included `app-test.hcl` demonstrates:
- Vault secret injection via templates
- Docker driver usage with BusyBox
- Workload Identity configuration
- Environment variable rendering from Vault secrets 