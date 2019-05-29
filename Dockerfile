FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /app
COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/runtime:2.2 AS runtime
WORKDIR /app
COPY --from=build app/out .
ENTRYPOINT ["dotnet", "hello-core.dll"]



#########################################################
# above script explained
#########################################################

# note: host-root-folder is host application folder where the Dockerfile exists in source code.
# downlaoding dotnet sdk image for build and named as build and set its working folder /app
# FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
# WORKDIR /app

# copied from host-root-folder-*.csproj file to build-image-working-folder (i.e app)
# COPY *.csproj .

# calling dotnet restore to get csproj nuget packages (the long way is RUN dotnet restore 'hello-core.csproj')
# RUN dotnet restore

# copy everything else from host-root-folder including *.cs, *.js, *.css, *.pngs, etc and copied to build-image-working-folder (i.e. app)
# COPY . .

# build and publish application at the build-image-out-floder which lies in build-image-working folder (i.e. /app/out/)
# RUN dotnet publish -c Release -o out

# downloading dotnet runtime image for running application and named as runtime and set its working folder /app
# FROM mcr.microsoft.com/dotnet/core/runtime:2.2 AS runtime
# WORKDIR /app

# copied all from build-image-app-out-folder to runtime-root-folder
# COPY --from=build app/out .

# setting the runtime default entry point which runs from terminal like [docker run 'hello-core']
# ENTRYPOINT ["dotnet", "hello-core.dll"]

#########################################################
# important docker commands
#########################################################

# build the app as an docker image
# docker build -t 'hello-core' .

# run the docker image in docker container
# docker run 'hello-core'

# run the docker image in docker container in interactive mode and set entry point to bash to see directory-structure and etc like (ls, dotnet --info)
# docker run -it --entrypoint 'bash' 'hello-core' 

# lists all docker container
# docker ps
# docker ps -a

# delete all docker container
# docker rm --force $(docker ps -a -q)

# lists all docker images
# docker images

# delete docker image
# docker rmi image -- force 'hello-core'

# lists dangling images 
# docker images -f dangling=true

# delete all dangling images
# docker rmi images $(docker images -f dangling=true -q)

#########################################################
# another snippet to build and publish 
#########################################################

# downlaoding dotnet sdk image for build and named as build and set working folder /app
# FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
# WORKDIR /app

# copied from host-root-folder-*.csproj file to build-image-working-folder (i.e app)
# COPY *.csproj .

# calling dotnet restore to get csproj nuget packages (the long way is RUN dotnet restore 'hello-core.csproj')
# RUN dotnet restore

# copy everything else from host-root-folder including *.cs, *.js, *.css, *.pngs, etc and copied to build-image-working-folder (i.e. app)
# COPY . .

# build application at the build-image-out-floder which lies at root folder (i.e. /out/)
# RUN dotnet build 'hello-core.csproj' -c Release -o /out

# publish application at the build-image-out-floder which lies at root folder (i.e. /out/)
# FROM build AS publish
# RUN dotnet publish 'hello-core.csproj' -c Release -o /out 


# FROM mcr.microsoft.com/dotnet/core/runtime:2.2 AS runtime
# WORKDIR /app
# COPY --from=build /out .
# ENTRYPOINT ["dotnet", "hello-core.dll"]