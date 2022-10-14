NEW_ENV=$1

#TODO  ANDROID

if [[ $NEW_ENV == "dev" ]]; then
    sed -i "" "s/PRODUCT_BUNDLE_IDENTIFIER = com.gardensitter.gardensitter/PRODUCT_BUNDLE_IDENTIFIER = \"com.gardensitter.gardensitter-preprod\"/" ios/Runner.xcodeproj/project.pbxproj
    sed -i "" "s/<string>com.gardensitter.gardensitter</<string>com.gardensitter.gardensitter-preprod</" ios/Runner/Info.plist
    sed -i "" "s/<string>GardenSitter</<string>GardenSitter-preprod</" ios/Runner/Info.plist
    sed -i "" "s/<string>com.googleusercontent.apps.960916263515-ekuhirr81o967t3dbbgo1m8nqs5r2cjd<\/string>/<string>com.googleusercontent.apps.239552629338-9higkqhlp0krdpg9q6261ikbc7m57fab<\/string>/" ios/Runner/Info.plist
    cp .secrets/GoogleService-Info-preprod.plist ios/Runner/GoogleService-Info.plist
    cp .secrets/google-services-preprod.json android/app/google-services.json
elif [[ $NEW_ENV == "production" ]]; then
    sed -i "" "s/PRODUCT_BUNDLE_IDENTIFIER = \"com.gardensitter.gardensitter-preprod\"/PRODUCT_BUNDLE_IDENTIFIER = com.gardensitter.gardensitter/" ios/Runner.xcodeproj/project.pbxproj
    sed -i "" "s/<string>com.gardensitter.gardensitter-preprod/<string>com.gardensitter.gardensitter/" ios/Runner/Info.plist
    sed -i "" "s/<string>GardenSitter-preprod</<string>GardenSitter</" ios/Runner/Info.plist
    sed -i "" "s/<string>com.googleusercontent.apps.239552629338-9higkqhlp0krdpg9q6261ikbc7m57fab/<string>com.googleusercontent.apps.960916263515-ekuhirr81o967t3dbbgo1m8nqs5r2cjd/" ios/Runner/Info.plist
    cp .secrets/GoogleService-Info-prod.plist ios/Runner/GoogleService-Info.plist
    cp .secrets/google-services-prod.json android/app/google-services.json
else
    echo "Wrong parameter : choose dev or production"
fi