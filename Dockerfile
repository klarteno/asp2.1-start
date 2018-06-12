
# build image
FROM microsoft/dotnet:2.1.300-sdk as build
WORKDIR /app

COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish --output /out/ --configuration Release

# runtime image
FROM microsoft/dotnet:2.1.0-aspnetcore-runtime
WORKDIR /app
COPY --from=build /out .
ENTRYPOINT [ "dotnet", "asp-start.dll" ]