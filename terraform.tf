terraform {
  required_providers {
    github = {
      source = "yann-soubeyrand/github"
    }

    null = {
      source = "hashicorp/null"
    }

    external = {
      source = "hashicorp/external"
    }
  }
}
