val ktor_version: String by project
val kotlin_version: String by project
val logback_version: String by project




plugins {
    id("application")
    id("com.github.johnrengelman.shadow") version "7.0.0"

    application
    kotlin("jvm") version "1.5.31"
}
tasks {
    shadowJar {
        manifest {
            attributes(Pair("Main-Class", "com.example.ApplicationKt"))
        }
    }
}


group = "com.example"
version = "0.0.1"

application {
    mainClass.set("com.example.ApplicationKt")

}

repositories {
    mavenCentral()
}

dependencies {
    implementation("io.ktor:ktor-server-core:$ktor_version")
    implementation("io.ktor:ktor-gson:$ktor_version")
    implementation("io.ktor:ktor-webjars:$ktor_version")
    implementation("org.webjars:jquery:3.2.1")
    implementation("io.ktor:ktor-websockets:$ktor_version")
    implementation("io.ktor:ktor-server-netty:$ktor_version")
    testImplementation("io.ktor:ktor-server-tests:$ktor_version")
    testImplementation("org.jetbrains.kotlin:kotlin-test-junit:$kotlin_version")
    implementation("ch.qos.logback:logback-classic:$logback_version")

    // https://mvnrepository.com/artifact/redis.clients/jedis
    implementation("redis.clients:jedis:4.0.0")
    implementation("com.auth0:java-jwt:3.18.2")

}