FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Como estamos dentro da pasta ContactApi, copiamos só o projeto e arquivos dela
COPY *.csproj ./
RUN dotnet restore

COPY . ./

RUN dotnet publish -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out ./

ENTRYPOINT ["dotnet", "ContactApi.dll"]
