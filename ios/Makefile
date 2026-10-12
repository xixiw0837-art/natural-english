# Requires Xcode and XcodeGen (brew install xcodegen)
.PHONY: generate build

generate:
	xcodegen generate --spec project.yml

build: generate
	xcodebuild -project NaturalEnglish.xcodeproj -scheme NaturalEnglish -sdk iphonesimulator -configuration Debug CODE_SIGNING_ALLOWED=NO build
