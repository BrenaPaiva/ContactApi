FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar arquivos do projeto para o container
COPY *.sln .
COPY ContactApi/*.csproj ./ContactApi/
RUN dotnet restore

# Copiar todo o código
COPY ContactApi/. ./ContactApi/

# Build e publish
WORKDIR /app/ContactApi
RUN dotnet publish -c Release -o /app/out

# Build da imagem runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "ContactApi.dll"]
