xcodebuild build-for-testing -scheme VideoUploaderIos-Example -workspace VideoUploaderIos.xcworkspace -destination 'platform=iOS Simulator,OS=14.4,name=iPhone 11'  -derivedDataPath 'build'
XCTESTRUN=`find ./build/Build/Products -name "*.xctestrun"`
perl -0777 -i.original -pe 's/<key>OS_ACTIVITY_DT_MODE<\/key>/<key>DELEGATED_TOKEN<\/key>\n<string>'$1'<\/string>\n<key>OS_ACTIVITY_DT_MODE<\/key>/igs' $XCTESTRUN
cat $XCTESTRUN
xcodebuild test-without-building -xctestrun $XCTESTRUN -destination 'platform=iOS Simulator,OS=14.4,name=iPhone 11'