# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk AS build
WORKDIR /app

# Copia o arquivo .csproj e restaura as dependências
COPY ContactApi.csproj ./
RUN dotnet restore

# Copia todos os arquivos do projeto
COPY . ./

# Compila o projeto
RUN dotnet publish -c Release -o out

# Etapa 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet
WORKDIR /app

# Copia os arquivos da build
COPY --from=build /app/out .

# Expõe a porta padrão (ajuste se for diferente)
EXPOSE 80

# Define o ponto de entrada
ENTRYPOINT ["dotnet", "ContactApi.dll"]