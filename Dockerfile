FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY *.sln ./
COPY *.csproj ./
# Se houver múltiplos projetos, repita para cada pasta de projeto

COPY . ./

RUN dotnet restore
RUN dotnet publish ContactApi.csproj -c Release -o /app/out --no-restore