# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia os arquivos de solução e projeto para restaurar as dependências primeiro
COPY ContactApi.sln ./
COPY ContactApi.csproj ./

RUN dotnet restore

# Copia o restante do código
COPY . .

# Publica sem restaurar novamente
RUN dotnet publish -c Release -o /app/out --no-restore

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/out .

EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

ENTRYPOINT ["dotnet", "ContactApi.dll"]