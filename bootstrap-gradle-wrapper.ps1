$ErrorActionPreference = "Stop"

$GradleVersion = "9.7.0"
$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$TempRoot = Join-Path $env:TEMP "koffient-gradle-wrapper-$GradleVersion"
$ZipPath = Join-Path $TempRoot "gradle-$GradleVersion-bin.zip"
$ExtractRoot = Join-Path $TempRoot "distribution"
$WrapperProject = Join-Path $TempRoot "wrapper-project"
$DistributionUrl = "https://services.gradle.org/distributions/gradle-$GradleVersion-bin.zip"

Write-Host "Bootstrapping official Gradle Wrapper $GradleVersion..."

if (Test-Path $TempRoot) {
    Remove-Item -Recurse -Force $TempRoot
}
New-Item -ItemType Directory -Force -Path $TempRoot, $ExtractRoot, $WrapperProject | Out-Null

Invoke-WebRequest -Uri $DistributionUrl -OutFile $ZipPath
Expand-Archive -Path $ZipPath -DestinationPath $ExtractRoot -Force

Set-Content -Path (Join-Path $WrapperProject "settings.gradle.kts") -Value 'rootProject.name = "wrapper-bootstrap"'
Set-Content -Path (Join-Path $WrapperProject "build.gradle.kts") -Value ''

$GradleBat = Join-Path $ExtractRoot "gradle-$GradleVersion\bin\gradle.bat"
& $GradleBat -p $WrapperProject wrapper --gradle-version $GradleVersion --distribution-type bin
if ($LASTEXITCODE -ne 0) {
    throw "Gradle wrapper generation failed with exit code $LASTEXITCODE"
}

Copy-Item -Force (Join-Path $WrapperProject "gradlew") $ProjectRoot
Copy-Item -Force (Join-Path $WrapperProject "gradlew.bat") $ProjectRoot
New-Item -ItemType Directory -Force -Path (Join-Path $ProjectRoot "gradle\wrapper") | Out-Null
Copy-Item -Force (Join-Path $WrapperProject "gradle\wrapper\gradle-wrapper.jar") (Join-Path $ProjectRoot "gradle\wrapper\gradle-wrapper.jar")
Copy-Item -Force (Join-Path $WrapperProject "gradle\wrapper\gradle-wrapper.properties") (Join-Path $ProjectRoot "gradle\wrapper\gradle-wrapper.properties")

Remove-Item -Recurse -Force $TempRoot
Write-Host "Done. Now run: .\gradlew.bat tasks"
