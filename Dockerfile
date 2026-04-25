#Stage 1: Build envoirnment
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

#copy everything into container
COPY . ./

#Restore dependency
RUN dotnet restore

#Build and publish the app
RUN dotnet publish -c Release -o out

#Stage 2 Runtime envoirnment
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

#Copy published output from build stage
COPY --from=build-env /app/out ./

#Run the application
ENTRYPOINT ["dotnet", "Myapp.dll"]
