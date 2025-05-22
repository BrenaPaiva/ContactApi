# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia a solução e o projeto (estão na raiz da pasta onde está o Dockerfile)
COPY ContactApi.sln ./
COPY ContactApi.csproj ./

RUN dotnet restore

# Copia o restante do código-fonte
COPY . .

RUN dotnet publish -c Release -o /app/out --no-restore

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/out .

EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

ENTRYPOINT ["dotnet", "ContactApi.dll"]
