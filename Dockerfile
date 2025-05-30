# Etapa 1: build da aplicação
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Copiar o arquivo .csproj e restaurar dependências
COPY ContactApi/*.csproj ./ContactApi/
WORKDIR /app/ContactApi
RUN dotnet restore

# Copiar o restante do código
COPY . .

# Publicar a aplicação em modo Release
RUN dotnet publish -c Release -o /app/out

# Etapa 2: imagem para rodar a aplicação
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Expor porta da API
EXPOSE 80

# Comando para iniciar a API
ENTRYPOINT ["dotnet", "ContactApi.dll"]
