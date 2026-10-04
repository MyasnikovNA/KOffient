# Koffient KMP bootstrap

This archive is intended to be copied into the existing Koffient project root.

It intentionally does **not** contain:
- `.idea/` — keep your existing IDE metadata locally; it is ignored by Git.
- `README.md` — keep your existing README.
- `KOffient.iml` — IntelliJ can regenerate module metadata after Gradle sync; it is ignored by Git.

## After copying

1. Copy the archive contents into the current project root.
2. On Windows, run once:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\bootstrap-gradle-wrapper.ps1
   ```

   This generates the official Gradle Wrapper JAR and replaces the temporary wrapper launchers with Gradle-generated ones.

3. Open/reload the project as a Gradle project and run **Gradle Sync**.
4. Make sure JDK 17+ is selected for Gradle. JDK 17 or 21 is fine for this scaffold.
5. Make sure Android SDK API 37 is installed (or lower `compileSdk` in `build.gradle.kts` to an installed SDK).

## Current targets

- Android KMP library target
- iOS x64 (simulator on Intel Mac)
- iOS arm64 (device)
- iOS simulator arm64 (Apple Silicon simulator)

On Windows, Apple targets can be configured and shared source code can be edited, but producing iOS binaries still requires macOS/Xcode.

## Versions pinned in this scaffold

- Kotlin / KGP: 2.4.20
- Android Gradle Plugin: 9.3.0
- Gradle: 9.7.0

No Koffient runtime architecture is included yet. `src/` is intentionally almost empty: this is only the correct KMP/Gradle foundation.
