data "github_repository" "this" {
  full_name = var.repository_name
}

# TODO: use suitable resource once it exists
# See https://github.com/integrations/terraform-provider-github/issues/542
data "external" "registration_token" {
  program = [
    "sh",
    "-c",
    "curl -s -H \"Authorization: token $GITHUB_TOKEN\" -X 'POST' 'https://api.github.com/repos/${data.github_repository.this.full_name}/actions/runners/registration-token'"
  ]
}

resource "null_resource" "this" {
  provisioner "ansible" {
    plays {
      playbook {
        file_path = "${path.module}/ansible/provisioner.yaml"
      }

      groups = var.groups

      extra_vars = {
        github_actions_runner_name               = var.name
        github_actions_runner_registration_url   = "https://github.com/${data.github_repository.this.full_name}"
        github_actions_runner_registration_token = data.external.registration_token.result.token
        github_actions_runner_labels             = join(",", var.labels)
      }

      diff = true
    }

    connection {
      host        = var.host
      user        = var.user
      private_key = var.private_key
    }

    ansible_ssh_settings {
      insecure_no_strict_host_key_checking = "true"
    }
  }

  # TODO: remove once suitable resource exists
  provisioner "local-exec" {
    when = destroy

    command = "curl -s -H \"Authorization: bearer $GITHUB_TOKEN\" -X 'DELETE' \"https://api.github.com/repos/${self.triggers.repository}/actions/runners/$(curl -s -H \"Authorization: bearer $GITHUB_TOKEN\" 'https://api.github.com/repos/${self.triggers.repository}/actions/runners' | jq -r '.runners[] | select(.name == \"${self.triggers.name}\").id')\""
  }

  triggers = {
    id         = var.id
    name       = var.name
    repository = data.github_repository.this.full_name
    groups     = join(", ", var.groups)
    labels     = join(", ", var.labels)
  }
}
