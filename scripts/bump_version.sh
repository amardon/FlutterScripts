VERSION_TYPE=$1

if [[ $VERSION_TYPE != "major" && $VERSION_TYPE != "minor" ]]; then    
    echo "Argument minor or major expected. (Use: bash bumpVersion.sh [version_type] [release_type])"
    exit
fi 

VERSION_CODE=$(grep "version:" pubspec.yaml | cut -d':' -f2 | cut -d'+' -f2)
VERSION_NAME=$(grep "version:" pubspec.yaml | cut -d':' -f2 | cut -d'+' -f1)
echo "Version actuelle : $VERSION_NAME code $VERSION_CODE"

YEAR=$(echo $VERSION_NAME | cut -d'.' -f1 )  
MAJOR_VERSION=$(echo $VERSION_NAME | cut -d'.' -f2 )    
MINOR_VERSION=$(echo $VERSION_NAME | cut -d'.' -f3) 


if [[ $VERSION_TYPE == "major" ]]; then
    NEXT_MAJOR=$((10#$MAJOR_VERSION+1))
    if [[ NEXT_MAJOR -lt 10 ]]; then
        NEXT_MAJOR="0$NEXT_MAJOR"
    fi
    NEXT_MINOR="00"
elif [[ $VERSION_TYPE == "minor" ]]; then
    NEXT_MINOR=$((10#$MINOR_VERSION+1))
    if [[ NEXT_MINOR -lt 10 ]]; then
        NEXT_MINOR="0$NEXT_MINOR"
    fi
    NEXT_MAJOR=$MAJOR_VERSION
fi

NEW_VERSION="$YEAR.$NEXT_MAJOR.$NEXT_MINOR"
NEW_CODE=$((10#$VERSION_CODE+1))

echo "Next Version : $NEW_VERSION code $NEW_CODE"


if [[ $OSTYPE == darwin* ]]; then
    sed -i "" "s/\(version: .*\)/version: $NEW_VERSION+$NEW_CODE/" pubspec.yaml 
  #  sed -i "" "s/\(VERSION_NAME=.*\)/VERSION_NAME=$NEW_VERSION/" gradle.properties
  #  sed -i "" "s/\(\"RATING_VERSION\":.*\)/\"RATING_VERSION\":\"$NEW_VERSION\",/" .secure/environment/env.json
else    
    sed -i "s/\(version: .*\)/version: $NEW_VERSION+$NEW_CODE/" pubspec.yaml 
  #  sed -i "s/\(VERSION_NAME=.*\)/VERSION_NAME=$NEW_VERSION/" gradle.properties
 #   sed -i "s/\(\"RATING_VERSION\":.*\)/\"RATING_VERSION\":\"$NEW_VERSION\",/" .secure/environment/env.json
fi

