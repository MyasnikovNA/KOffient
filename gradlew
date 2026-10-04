#!/bin/sh
set -e
PROJECT_ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
if [ ! -f "$PROJECT_ROOT/gradle/wrapper/gradle-wrapper.jar" ]; then
  echo "Gradle Wrapper JAR is not present yet."
  echo "On Windows run: powershell -ExecutionPolicy Bypass -File ./bootstrap-gradle-wrapper.ps1"
  exit 1
fi
exec java -classpath "$PROJECT_ROOT/gradle/wrapper/gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain "$@"
