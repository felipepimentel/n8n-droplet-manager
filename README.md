# n8n Droplet Manager

Automate the provisioning and management of an n8n Droplet on DigitalOcean using GitHub Actions and OpenTofu 1.8.0. This repository allows you to control your Droplet's lifecycle (start/stop) via GitHub issues while following best practices in infrastructure as code.

## Key Features

- Automated provisioning of n8n Droplet using OpenTofu 1.8.0.
- Lifecycle management (start/stop) via GitHub Actions triggered by issues.
- Integrated monitoring and alerting.
- Snapshot backups for disaster recovery.
- Scalable setup with DigitalOcean Load Balancer.

## Setup

1. Clone the repository.
2. Run the `setup.sh` script located in the `scripts/` directory.
3. Follow the prompts to configure the environment and provision your Droplet.

## Contributing

Please refer to the `CONTRIBUTING.md` file for details on how to contribute to this project.
