# Basic self-token maintenance (usually safe and useful)
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

path "auth/token/renew-self" {
  capabilities = ["update"]
}

path "auth/token/revoke-self" {
  capabilities = ["update"]
}

path "secret/data/test/secret-key" {
    capabilities = ["read"]
}

# Example: allow read access to specific app secrets in a KV v2 engine mounted at "kv"
# Adjust the path to your mount and secret locations.
path "kv/data/apps/*" {
  capabilities = ["read"]
}

# Additional useful paths for Nomad workloads
path "secret/data/*" {
  capabilities = ["read"]
}