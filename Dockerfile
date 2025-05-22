# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia somente os arquivos necessários para restaurar as dependências primeiro
COPY ContactApi.sln ./
COPY ContactApi/*.csproj ./ContactApi/

# Restaura dependências - assim o cache funciona melhor se só o código mudar depois
RUN dotnet restore ContactApi.sln

# Copia o restante do código
COPY . .

# Compila e publica a aplicação em Release
RUN dotnet publish ContactApi.csproj -c Release -o /app/out --no-restore

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copia os artefatos da build
COPY --from=build /app/out .

EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

ENTRYPOINT ["dotnet", "ContactApi.dll"]
