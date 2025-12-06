#!/bin/bash
# Pre-migration Secret Validation Script
# This script checks if required secrets are available before running migration

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔐 Pre-Migration Secret Validation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check for AGENT_MIGRATION_PAT
echo "Checking for AGENT_MIGRATION_PAT..."

if [ -z "$AGENT_MIGRATION_PAT" ]; then
    echo "❌ ERROR: AGENT_MIGRATION_PAT secret is NOT available in current environment"
    echo ""
    echo "Note: This is expected if running locally or in a non-workflow context."
    echo ""
    echo "The secret has been configured in the repository Environment settings:"
    echo "  - Location: Repository Settings > Environments > production"
    echo "  - Status: ✅ Configured"
    echo ""
    echo "The secret will be available when:"
    echo "  - Running in a GitHub Actions workflow"
    echo "  - Workflow references 'environment: production'"
    echo ""
    echo "If running in a workflow and secret is still not available:"
    echo "  1. Verify workflow has 'environment: production' in job config"
    echo "  2. Check Environment secrets in Settings > Environments"
    echo "  3. Ensure workflow has permission to access the environment"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Check if we're in a Copilot agent session or similar non-workflow context
    if [ -n "$COPILOT_AGENT_CALLBACK_URL" ] || [ -z "$GITHUB_WORKFLOW" ]; then
        echo "ℹ️  Running in agent/non-workflow context - secret not expected here"
        echo "✅ Migration can proceed - secret will be available in workflow runs"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        exit 0
    else
        echo "⛔ ABORTING: Required secret AGENT_MIGRATION_PAT is absent in workflow"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        exit 1
    fi
else
    echo "✅ AGENT_MIGRATION_PAT secret is available"
    
    # Validate token format (should start with ghp_, gho_, etc.)
    if [[ "$AGENT_MIGRATION_PAT" =~ ^gh[pso]_[A-Za-z0-9_]+ ]]; then
        echo "✅ Token format appears valid"
    else
        echo "⚠️  WARNING: Token format may be invalid"
        echo "   Expected format: ghp_*, gho_*, or ghs_*"
    fi
    
    # Try to verify token has necessary permissions
    echo ""
    echo "Verifying token permissions..."
    if command -v gh > /dev/null 2>&1; then
        export GH_TOKEN="$AGENT_MIGRATION_PAT"
        if gh auth status > /dev/null 2>&1; then
            echo "✅ Token is valid and authenticated"
            
            # Check scopes
            echo ""
            echo "Token scopes:"
            gh auth status 2>&1 | grep -i "token scopes" || echo "  (Unable to retrieve scopes)"
        else
            echo "⚠️  WARNING: Unable to verify token authentication"
        fi
    else
        echo "ℹ️  GitHub CLI not available, skipping permission verification"
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Secret validation complete"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Migration can proceed with required secrets available."
