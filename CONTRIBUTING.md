# Contributing to aioboss-agentic

Thank you for your interest in contributing to **aioboss-agentic** - the AIOBoss Agentic Office DevOps Single Source of Truth (SSOT) project! We welcome contributions from the community.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Agent Development](#agent-development)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for all contributors.

## Getting Started

### Prerequisites

- Git
- GitHub account
- Basic understanding of GitHub Actions and workflows

### Setup

1. **Fork the repository**
   ```bash
   gh repo fork chakssp/aioboss-agentic --clone
   ```

2. **Create a branch for your changes**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the coding standards
   - Write tests if applicable
   - Update documentation

## Development Workflow

### Creating an Issue

Before submitting a pull request, it is **strongly recommended** to [create an issue](https://github.com/chakssp/aioboss-agentic/issues/new) first to discuss your proposed changes. This helps:
- Ensure alignment with project goals
- Avoid duplicating work in progress
- Get feedback early in the process

### Making Changes

1. **Keep changes focused**: Each PR should address a single concern
2. **Write clear commit messages**: Use descriptive commit messages
3. **Test your changes**: Verify your changes work as expected
4. **Update documentation**: Keep docs in sync with code changes

## Agent Development

When developing or modifying GitHub Copilot agents:

### Agent Configuration

1. **Location**: All agent configurations must be in `.github/agents/`
2. **Template**: Use `.github/agents/.agent.md` as a template
3. **Naming**: Use clear, descriptive names for agents
4. **Documentation**: Include README.md for each agent

### Agent Structure

```
.github/agents/
├── .agent.md              # Template
├── your-agent/
│   ├── config.yml         # Agent configuration
│   ├── README.md          # Agent documentation
│   └── workflows/         # Agent-specific workflows
```

### Validation

All agent configurations are automatically validated using the `agents-metadata-check` workflow. Ensure your changes pass validation:

```bash
# Trigger validation workflow
gh workflow run agents-metadata-check.yml
```

### Required Metadata

Each agent must include:
- **Name**: Clear, descriptive name
- **Version**: Semantic versioning (e.g., 1.0.0)
- **Type**: Agent type (swe-agent, review, docs, etc.)
- **Description**: Brief description of capabilities
- **Owner**: Team or person responsible

## Pull Request Process

### Before Submitting

1. ✅ Ensure your changes pass all validation checks
2. ✅ Update relevant documentation
3. ✅ Add tests if applicable
4. ✅ Verify no unrelated changes are included
5. ✅ Check for merge conflicts

### Submitting a PR

1. **Push your branch**
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create a Pull Request**
   - Use a clear, descriptive title
   - Reference related issues (e.g., "Fixes #123")
   - Provide detailed description of changes
   - Add screenshots for UI changes

3. **PR Template**
   ```markdown
   ## Description
   Brief description of changes
   
   ## Related Issues
   - Fixes #123
   - Related to #456
   
   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Documentation update
   - [ ] Agent configuration
   
   ## Testing
   - [ ] All tests pass
   - [ ] New tests added (if applicable)
   - [ ] Validation workflow passes
   
   ## Checklist
   - [ ] Code follows project standards
   - [ ] Documentation updated
   - [ ] No unrelated changes
   ```

### Review Process

- PRs require approval from maintainers
- Address review feedback promptly
- Keep PR scope focused
- Be responsive to questions

### Merging

- PRs are merged by maintainers after approval
- Squash merging is preferred for cleaner history
- Delete branch after merging

## Coding Standards

### General Guidelines

- **Clarity**: Write clear, readable code
- **Simplicity**: Prefer simple solutions
- **Consistency**: Follow existing patterns
- **Comments**: Document complex logic

### YAML Files

- Use 2 spaces for indentation
- Include comments for complex configurations
- Validate YAML syntax before committing

### Markdown Files

- Use proper heading hierarchy
- Include code examples where helpful
- Keep line length reasonable (~80-120 chars)

## Testing

### Workflow Testing

Test GitHub workflows locally when possible:

```bash
# Using act (local GitHub Actions runner)
act -j validate-agents-metadata
```

### Agent Testing

- Test agent configurations in isolated environments
- Verify agent triggers work correctly
- Check permissions are appropriate

## Documentation

### Keep Updated

- Update README.md for user-facing changes
- Update agent-architecture.md for structural changes
- Update MIGRATION-LOG.md for migration steps

### Documentation Standards

- Use clear, concise language
- Include examples
- Keep diagrams up-to-date
- Link to related documentation

## Migration Guidelines

When working on migrations:

1. **Create migration branch**: Use format `migration/agents-ssot-YYYYMMDD`
2. **Document changes**: Update MIGRATION-LOG.md
3. **Test thoroughly**: Verify all changes work correctly
4. **Create draft PR**: Mark PR as draft until ready
5. **Get approval**: Obtain approval before merging

### Required Secrets

Some operations may require secrets:
- `AGENT_MIGRATION_PAT`: Personal Access Token for migrations

Ensure secrets are configured before running automated workflows.

## Getting Help

- **Questions**: Open an issue with the `question` label
- **Bugs**: Open an issue with the `bug` label
- **Feature Requests**: Open an issue with the `enhancement` label

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

## Thank You!

Your contributions make this project better. We appreciate your time and effort! 🙏

---

**Last Updated**: 2025-12-06
