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

# Native image build, free from JDK and other stuff
FROM ghcr.io/graalvm/native-image-community:25

WORKDIR /app

# Allow Spring profile override
ARG SPRING_PROFILE=default
ENV SPRING_PROFILES_ACTIVE=${SPRING_PROFILE}

# Copy native binary from build stage
COPY --from=builder /workspace/build/native/nativeCompile/ /app

EXPOSE 8080

ENTRYPOINT ["/app/graal.vm.demo"]
