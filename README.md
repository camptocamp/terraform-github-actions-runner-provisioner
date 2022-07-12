# terraform-github-actions-runner-provisioner

Terraform provisioner for a self-hosted GitHub Actions runner


## Prerequisites :
 * An SSH connection to the runner VM.
 * ansible and ansible-playbook commands installed on the host launching the terraform.
 * setfacl tool installed on the runner VM.


## Usage :

Here is an example for using the module :

```
module "github_actions_runner_provisioner" {
  source = "git::https://github.com/camptocamp/terraform-github-actions-runner-provisioner.git"

  id              = aws_instance.this.id
  name            = "github-actions-runner"
  repository_name = "myrepo"
  groups = [
    "terraform",
  ]

  host        = aws_instance.this.public_ip
  user        = "ubuntu"
  private_key = tls_private_key.this.private_key_openssh
}
```

## Inputs :

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [id](https://github.com/camptocamp/terraform-github-actions-runner-provisioner/blob/af6391bbf58a17ceed33eab063e414ab6c2c3b2a/variables.tf#L1) | Arbitrary string linked to the VM used for recreating the provisioner if the host has been changed. | `string` | `""` | no |
| [name](https://github.com/camptocamp/terraform-github-actions-runner-provisioner/blob/af6391bbf58a17ceed33eab063e414ab6c2c3b2a/variables.tf#L7) | Name of the runner in Github | `string` | `nil` | yes |
| [repository_name](https://github.com/camptocamp/terraform-github-actions-runner-provisioner/blob/af6391bbf58a17ceed33eab063e414ab6c2c3b2a/variables.tf#L11) | Short repository name where to link the runner | `string` | `nil` | yes |
| [groups](https://github.com/camptocamp/terraform-github-actions-runner-provisioner/blob/af6391bbf58a17ceed33eab063e414ab6c2c3b2a/variables.tf#L15) | Ansible groups | `list(string)` | `nil` | yes |
| [labels](https://github.com/camptocamp/terraform-github-actions-runner-provisioner/blob/af6391bbf58a17ceed33eab063e414ab6c2c3b2a/variables.tf#L19) | Additional labels for the runner | `list(string)` | `[]` | no |
| [host](https://github.com/camptocamp/terraform-github-actions-runner-provisioner/blob/af6391bbf58a17ceed33eab063e414ab6c2c3b2a/variables.tf#L26) | DNS or public IP to connect to the runner VM | `string` | `nil` | yes |
| [user](https://github.com/camptocamp/terraform-github-actions-runner-provisioner/blob/af6391bbf58a17ceed33eab063e414ab6c2c3b2a/variables.tf#L30) | Username to connect to the runner VM | `string` | `nil` | yes |
| [private_key](https://github.com/camptocamp/terraform-github-actions-runner-provisioner/blob/af6391bbf58a17ceed33eab063e414ab6c2c3b2a/variables.tf#L34) | SSH private key to connect to the runner VM | `string` | `nil` | yes |

