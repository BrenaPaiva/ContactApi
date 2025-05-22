# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia o .csproj e restaura dependências
COPY *.csproj ./
RUN dotnet restore

# Copia todos os arquivos restantes e publica
COPY . ./
RUN dotnet publish -c Release -o /app/out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

ENTRYPOINT ["dotnet", "ContactApi.dll"]
