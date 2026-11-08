plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.jrostero.fulldays_mobile"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // Identificador provisional hasta definir la marca: cambiarlo antes de la primera publicación.
        applicationId = "com.jrostero.fulldays"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // Un flavor por entorno, cada uno instalable a la vez en el mismo teléfono.
    // La URL de la API viaja aparte: --dart-define-from-file=env/<flavor>.json
    flavorDimensions += "entorno"
    productFlavors {
        create("dev") {
            dimension = "entorno"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "FullDays Dev")
        }
        create("stg") {
            dimension = "entorno"
            applicationIdSuffix = ".stg"
            resValue("string", "app_name", "FullDays Pruebas")
        }
        create("prod") {
            dimension = "entorno"
            resValue("string", "app_name", "FullDays")
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
