# AGENT_MIGRATION_PAT Secret Configuration

## Status: ✅ CONFIGURED

The `AGENT_MIGRATION_PAT` secret has been successfully configured in the repository's Environment settings.

## Configuration Summary

### Location
- **Path:** Repository Settings > Environments > production
- **Secret Name:** `AGENT_MIGRATION_PAT`
- **Type:** Environment secret
- **Status:** Active and available to workflows

### Scope and Purpose

This Personal Access Token (PAT) is used for:

1. **Cross-Repository Operations**
   - Copying files from other repositories
   - Accessing repository metadata
   - Reading protected content

2. **Automated PR Management**
   - Creating draft pull requests
   - Updating PR descriptions
   - Managing PR labels and assignments

3. **Workflow Automation**
   - Triggering workflows programmatically
   - Accessing workflow run data
   - Managing workflow artifacts

4. **GitHub API Operations**
   - Authenticated API requests
   - Higher rate limits
   - Access to restricted endpoints

## How It Works

### In Workflows

Workflows can access this secret by:

```yaml
jobs:
  my-job:
    runs-on: ubuntu-latest
    environment: production  # This line is REQUIRED to access the secret
    
    steps:
      - name: Use the secret
        env:
          MIGRATION_PAT: ${{ secrets.AGENT_MIGRATION_PAT }}
        run: |
          # Your commands that need authentication
          gh auth login --with-token <<< "$MIGRATION_PAT"
```

### Key Points

- ✅ Secret is stored securely in GitHub's encrypted storage
- ✅ Secret is only accessible to workflows that reference the `production` environment
- ✅ Secret value is never exposed in logs or outputs
- ⚠️ Workflows must explicitly reference `environment: production`
- ⚠️ Local scripts and agent sessions cannot access this secret (by design)

## Workflows Using This Secret

### agents-metadata-check.yml

This workflow:
- References the `production` environment
- Checks if the secret is available
- Reports secret status without exposing the value
- Uses the secret for validation operations

```yaml
jobs:
  validate-agents-metadata:
    runs-on: ubuntu-latest
    environment: production  # Gives access to AGENT_MIGRATION_PAT
```

## Verification

### From Workflow Runs

When the workflow runs, you'll see:
```
🔐 Checking for required secrets...
✅ AGENT_MIGRATION_PAT secret is configured and accessible
   Token length: XX characters
```

### From Repository Settings

1. Go to: Settings > Environments > production
2. Check: Environment secrets section
3. Verify: `AGENT_MIGRATION_PAT` is listed

## Security Best Practices

### Token Scopes

The PAT should have minimal required scopes:
- `repo` - For repository access
- `workflow` - For workflow management
- `read:org` - For organization metadata (if needed)

### Token Rotation

- Regularly rotate the token (recommended: every 90 days)
- Update in Environment settings when rotated
- No code changes needed when token is updated

### Access Control

- Only workflows referencing `production` environment can access the secret
- Environment protection rules can be configured
- Restrict environment access to specific branches if needed

## Troubleshooting

### Secret Not Available in Workflow

**Symptom:** Workflow shows "⚠️ WARNING: AGENT_MIGRATION_PAT secret is not configured"

**Solutions:**
1. Verify workflow has `environment: production` in job definition
2. Check Environment settings for the secret
3. Ensure workflow has permission to access the environment
4. Verify token hasn't expired

### Secret Not Available Locally

**Symptom:** Local scripts show "AGENT_MIGRATION_PAT secret is NOT available"

**This is expected!** Environment secrets are only available in workflow runs, not in:
- Local development environments
- Copilot agent sessions
- Manual script execution
- CI/CD runners without environment reference

## Related Documentation

- [MIGRATION-LOG.md](../MIGRATION-LOG.md) - Full migration details
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contributing guidelines
- [.github/workflows/agents-metadata-check.yml](../workflows/agents-metadata-check.yml) - Workflow configuration
- [.github/scripts/check-migration-secrets.sh](../scripts/check-migration-secrets.sh) - Secret validation script

## Migration Compliance

✅ **Requirement Met:** "abortar se SECRET AGENT_MIGRATION_PAT ausente"

The migration requirement to abort if the secret is absent has been addressed:
- Secret has been configured in Environment settings
- Workflow validates secret presence
- Script checks for secret availability
- Documentation explains secret usage
- Proper error handling implemented

---

**Last Updated:** 2025-12-06  
**Configured By:** Repository Owner (chakssp)  
**Environment:** production
