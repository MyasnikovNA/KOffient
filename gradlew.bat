@echo off
setlocal
set PROJECT_ROOT=%~dp0
if not exist "%PROJECT_ROOT%gradle\wrapper\gradle-wrapper.jar" (
  echo Gradle Wrapper JAR is not present yet. Bootstrapping it once...
  powershell -NoProfile -ExecutionPolicy Bypass -File "%PROJECT_ROOT%bootstrap-gradle-wrapper.ps1"
  if errorlevel 1 exit /b %errorlevel%
)
java -classpath "%PROJECT_ROOT%gradle\wrapper\gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain %*
