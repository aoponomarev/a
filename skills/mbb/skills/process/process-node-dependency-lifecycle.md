# Node.js Dependency & Lifecycle Management (v1.0)

> **Goal**: Maintain a clean, secure, and up-to-date dependency tree.
> **Skill Anchor**: `package.json`

## 📦 DEPENDENCIES (С2)

- **Audit**: Run `npm run audit` regularly to check for vulnerabilities.
- **Lockfile**: Always commit `package-lock.json` to ensure reproducible builds.
- **Engines**: Specify `engines` in `package.json` to enforce Node.js version compatibility.

## 🧪 TESTING (Ф1)

- **Native Runner**: Use `node --test` for lightweight, dependency-free testing.
- **CI/CD**: Ensure `npm test` and `npm run audit` pass in GitHub Actions.

## 🚀 DEPLOYMENT

- **Clean Install**: Use `npm ci --production` in Dockerfiles to install only production dependencies based on the lockfile.
