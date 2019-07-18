FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env

# Allow user to specify torinox package and version
ARG TORINOX_PACKAGE_NAME=torinox
ARG TORINOX_VERSION=latest

RUN echo "Installing $TORINOX_PACKAGE_NAME, version $TORINOX_VERSION" && \
    if [ "$TORINOX_VERSION" = "latest" ]; then \
    dotnet tool install -g "$TORINOX_PACKAGE_NAME"; \
    else dotnet tool install -g --version="$TORINOX_VERSION" "$TORINOX_PACKAGE_NAME"; fi

FROM mcr.microsoft.com/dotnet/core/runtime:2.2
COPY --from=build-env /root/.dotnet/tools /root/.dotnet/tools
ENV PATH="${PATH}:/root/.dotnet/tools"
