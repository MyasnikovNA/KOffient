import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidKotlinMultiplatformLibrary)
}

group = "dev.koffient"
version = "0.1.0-SNAPSHOT"

kotlin {
    android {
        namespace = "dev.koffient"
        compileSdk = 37
        minSdk = 24

        compilerOptions {
            jvmTarget.set(JvmTarget.JVM_17)
        }
    }

    iosX64()
    iosArm64()
    iosSimulatorArm64()

    sourceSets {
        commonMain.dependencies {
            // Common dependencies will go here later.
        }

        commonTest.dependencies {
            implementation(kotlin("test"))
        }
    }
}
