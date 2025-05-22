# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia arquivos e restaura dependências
COPY *.csproj ./
RUN dotnet restore

# Copia o restante e faz o build
COPY . ./
RUN dotnet publish -c Release -o out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# Define a porta padrão (ajuste se necessário)
EXPOSE 80

ENTRYPOINT ["dotnet", "ContactApi.dll"]
