#Partir d'une image de référence ubuntu en version 24:10
FROM ubuntu:25.10 AS builder
# Installation du SDK dotnet 9
RUN apt-get update && apt-get install -y dotnet-sdk-9.0 ca-certificates
# Ajouter le code source de l'application
WORKDIR /source
COPY . .
# Publication de l'app dotnet
RUN dotnet publish ./my-first-app.csproj -c Release -o /app
FROM ubuntu:25.10 AS prod
# Récupération des DLL de l'application
WORKDIR /app
COPY --from=builder /app ./
# Installation du SDK dotnet pour un run local
RUN apt-get update && apt-get install -y dotnet-sdk-9.0
# Entrypoint d'exécution de l'application
ENTRYPOINT ["dotnet", "my-first-app.dll"]