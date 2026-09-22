# Linux release validation

`Linux release checks` runs on every push and pull request using the official Swift 6.2.4 Ubuntu 22.04 image on an x86-64 runner. It performs the production static build, then invokes the same `bin/post_compile` regression gate used by Heroku. It never deploys.

Keep `.swift-version`, the workflow image/version check, and intentional dependency updates in sync. Include `Package.resolved` in commits; it is no longer ignored. CI verifies it remains unchanged.

## One-time activation

After pushing the workflow, verify its first run succeeds. In Heroku's website app, open **Deploy → Automatic deploys** and enable **Wait for CI to pass before deploy**. Keep the deployed branch pointed at the intended branch. This prevents automatic deployment from starting until GitHub's checks pass; the existing Heroku test hook remains a second gate.

Official instructions: https://devcenter.heroku.com/articles/github-integration#automatic-deploys

The workflow has been syntax-checked locally, but its first Linux execution must happen on GitHub. Do not infer Linux success from local macOS tests. Martin owns all commits, pushes, deployment settings, and deployments.
