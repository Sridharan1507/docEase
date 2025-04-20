buildscript {
    extra.apply {
        set("kotlin_version", "1.9.20")
    }
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.1.2")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.20") // Use dynamic version
    }
}

allprojects {
   repositories {
    google()
    mavenCentral()
    jcenter() // Sometimes deprecated, use only if necessary.
    maven { url = uri("https://jitpack.io") } // For certain third-party libraries.
}

}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir) // Use .set() instead of .value()

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir) // Use .set() instead of .value()
    
    // Moved evaluationDependsOn inside the subprojects block
    afterEvaluate {
        if (project.name != "app") {
            evaluationDependsOn(":app")
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}