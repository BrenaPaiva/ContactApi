FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY *.sln ./
COPY src/*.csproj ./src/
# Se houver múltiplos projetos, repita para cada pasta de projeto

COPY . ./

RUN dotnet restore
RUN dotnet publish -c Release -o /app/out --no-restore