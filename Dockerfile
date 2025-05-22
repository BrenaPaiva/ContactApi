FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY *.sln ./
# Copie a solução
COPY *.sln ./

# Copie os arquivos de projeto e dependências
COPY ContactApi/*.csproj ./ContactApi/

# Copie o restante do código-fonte
COPY . ./

RUN dotnet restore
RUN dotnet publish ContactApi.csproj -c Release -o /app/out --no-restore