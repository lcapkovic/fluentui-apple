#!/bin/bash

# Check if environment variables have been defined for our team ID, AAD App ID, and AAD App Secret for automated workflows before requesting them interactively
if [ -z $TDBUILD_TEAM_ID ]; then
    printf "Team ID: "
    read TDBUILD_TEAM_ID
fi

if [ -z $TDBUILD_AAD_APPLICATION_CLIENT_ID ]; then
    printf "Alias: "
    read TDBUILD_AAD_APPLICATION_CLIENT_ID
fi

if [ -z $TDBUILD_AAD_APPLICATION_CLIENT_SECRET ]; then
    stty -echo
    printf "Password: "
    read TDBUILD_AAD_APPLICATION_CLIENT_SECRET
    stty echo
    printf "\n"
fi

# Localize iOS resources
scripts/GetLocalizedFiles.sh -t $TDBUILD_TEAM_ID -u -a $TDBUILD_AAD_APPLICATION_CLIENT_ID -p $TDBUILD_AAD_APPLICATION_CLIENT_SECRET -f Sources/FluentUI_iOS/Resources/Localization/en.lproj -r ios -o Sources/FluentUI_iOS/Resources/Localization

# Localize macOS resources
scripts/GetLocalizedFiles.sh -t $TDBUILD_TEAM_ID -u -a $TDBUILD_AAD_APPLICATION_CLIENT_ID -p $TDBUILD_AAD_APPLICATION_CLIENT_SECRET -f Sources/FluentUI_macOS/Resources/Strings/en.lproj -r macos -o Sources/FluentUI_macOS/Resources/Strings
