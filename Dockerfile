FROM optum-docker-builders.bintray.io/nativeimage:graalvm-ce-21.0.0-java11

# Copy shaded native jar into build
COPY native-image.jar /tmp/native-image.jar

# Define the working directory
WORKDIR /tmp

# Build the native image
RUN native-image -cp native-image.jar \
    -H:+ReportExceptionStackTraces \
    --report-unsupported-elements-at-runtime \
    --no-fallback \
    --static
