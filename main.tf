# Declare the required provider
provider "conjur" {
  appliance_url = var.conjur_url          # Conjur Cloud URL
  account       = var.conjur_account      # Conjur account name
  authn_type    = "jwt"                   # Specify authentication type as JWT
  jwt_token     = var.jwt_token           # JWT token provided during execution
}

# Retrieve the secret from the specified path
data "conjur_secret" "db_password" {
  name = "secrets/db/credentials/password" # Path to the secret in Conjur
}

# Output the secret (use cautiously; avoid displaying sensitive data in logs)
output "db_password" {
  value       = data.conjur_secret.db_password.value
  sensitive   = true  # Marks the output as sensitive to mask it in Terraform outputs
}
