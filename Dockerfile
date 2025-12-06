# Stage 1: Build the native image
FROM ghcr.io/graalvm/graalvm-community:latest AS builder

WORKDIR /workspace

# Just download gradle first
COPY gradlew gradlew.bat /workspace
COPY gradle/ /workspace/gradle
RUN ./gradlew --version

# Just copy the code
COPY build.gradle.kts settings.gradle.kts /workspace
COPY src/ /workspace/src

# Build using Gradle wrapper
RUN ./gradlew nativeCompile --no-daemon

# Support for spring.profiles.active
ARG SPRING_PROFILE=default
ENV SPRING_PROFILES_ACTIVE=$SPRING_PROFILE

EXPOSE 8080
ENTRYPOINT ["/workspace/build/native/nativeCompile/graal.vm.demo"]
