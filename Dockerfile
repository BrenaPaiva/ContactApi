# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY ContactApi/*.csproj ./ContactApi/
RUN dotnet restore ./ContactApi/ContactApi.csproj

COPY . ./
RUN dotnet publish ./ContactApi/ContactApi.csproj -c Release -o /app/out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "ContactApi.dll"]
