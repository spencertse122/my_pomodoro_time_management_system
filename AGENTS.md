# Repository Guidelines

## Project Structure & Module Organization

This is a minimal Pomodoro time-management project scaffold. `README.md` is the starting point for documentation. As the application is implemented, keep the layout predictable:

- `src/` for production source code, organized by feature (for example, `src/timer/` and `src/tasks/`).
- `tests/` for automated tests mirroring `src/` paths.
- `assets/` for static images, sounds, and other checked-in resources.
- `docs/` for longer design notes or setup guides when the README is no longer sufficient.

Avoid application code in the repository root. Keep generated output, caches, and secrets out of version control.

## Build, Test, and Development Commands

No runtime, package manager, or test tooling has been committed yet. When adding the first implementation, document its canonical commands in `README.md`. A JavaScript/TypeScript application would typically provide:

```sh
npm install       # install declared dependencies
npm run dev       # start the local development server
npm test          # run the automated test suite
npm run build     # create a production build
```

Prefer package scripts over undocumented one-off commands.

## Coding Style & Naming Conventions

Use the chosen formatter and linter; commit their configuration with the code. Prefer 2-space indentation for JSON, YAML, and web code unless the formatter dictates otherwise. Name files and directories in `kebab-case` (`pomodoro-timer.ts`), use `PascalCase` for UI components/classes, and `camelCase` for functions and variables. Keep modules focused and name them for timer behavior or domain concepts.

## Testing Guidelines

Add tests under `tests/` or a tool-supported colocated convention. Name tests after the behavior being verified, such as `timer-pauses-when-break-starts.test.ts`. Cover timer state transitions, duration calculations, notifications, and persistence edge cases. Run the full suite before opening a pull request; add regression coverage for defects.

## Commit & Pull Request Guidelines

The existing history contains only an initial commit, so no commit convention exists. Use concise, imperative messages such as `feat: add configurable break durations` or `fix: preserve timer state on refresh`. Keep commits narrowly scoped. Pull requests should explain the change, list validation performed, link relevant issues, and include screenshots or recordings for UI changes.

## Security & Configuration

Never commit credentials, API keys, or personal configuration. Provide safe defaults in an example configuration file (for example, `.env.example`) and document required environment variables in the README.
