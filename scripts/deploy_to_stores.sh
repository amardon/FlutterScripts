echo "Switch to production env"
bash switch_environment.sh production

echo "Bump version"
bash bump_version.sh minor

echo "Building ios ..."
fvm flutter build ipa

echo "Building android ..."
fvm flutter build appbundle

echo ""
echo "Pushing to TestFlight"
cd ios
fastlane ios beta

cd ..

echo ""
echo "Pushing to Play beta"
cd android
fastlane android beta


echo ""
echo "Done"