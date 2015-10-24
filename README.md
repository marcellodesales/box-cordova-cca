box-cordova-cca
===========

[![wercker status](https://app.wercker.com/status/66beaf20c9d5a75e6a9f664bda7f5be3/m "wercker status")](https://app.wercker.com/project/bykey/66beaf20c9d5a75e6a9f664bda7f5be3)

A wercker box for building, testing and deploying CCA apps (Mobile Chrome Apps) https://github.com/MobileChromeApps

For build information go to https://app.wercker.com/#search/boxes/cordova-cca

Examples
-------

Building CCA apps is very simple. Just create a wercker.yml file in your app... Adjust the steps below according to your specifications. Then, you can use a Deploy step to upload your APK to Amazon S3, for instance.

```yml
box: marcellodesales/cordova-cca@0.0.9
build:
        steps:
                - script:
                        name: Install Node dependencies
                        code: sudo npm install
                - script:
                        name: Update the path with the binaries from Node
                        code: export PATH="$WERCKER_SOURCE_DIR/node_modules/.bin:$PATH"
                - script:
                        name: Install Bower dependencies
                        code: bower install
                - script:
                        name: Setup project settings for CCA with Gulp
                        code: gulp
                - script:
                        name: Setup and generate the Android Platform on CCA
                        code: cd build && cca analytics disable && cca platform add android && cca plugin add org.apache.cordova.device --skip-upgrade && cca plugin add ../plugins/com.quantogastei.app --skip-upgrade && cca build android --skip-upgrade
                - script:
                        name: Create final versioned file based on the commit SHA
                        code: APK_FILE=$WERCKER_BUILD_ID-$(echo $WERCKER_GIT_COMMIT | cut -b 1-7).apk && cp $WERCKER_SOURCE_DIR/build/platforms/android/build/outputs/apk/android-armv7-debug.apk $WERCKER_OUTPUT_DIR && cp $WERCKER_SOURCE_DIR/build/platforms/android/build/outputs/apk/android-armv7-debug.apk $WERCKER_OUTPUT_DIR/$APK_FILE
        after-steps:
                - wantedly/pretty-slack-notify:
                        webhook_url: $SLACK_WEBHOOK_BUILD
deploy:
        steps:
                # Execute the s3sync deploy step, a step provided by wercker
                - s3sync:
                        key_id: $AWS_ACCESS_KEY_ID
                        key_secret: $AWS_SECRET_ACCESS_KEY
                        bucket_url: $AWS_BUCKET_URL
                        source_dir: .
                # Notify slack
        after-steps:
                - wantedly/pretty-slack-notify:
                        webhook_url: $SLACK_WEBHOOK_DEPLOYMENT
```

Each step is displayed in the Wercker UI using the description used in the yml descriptor.

<img src='http://s24.postimg.org/a1juefdh1/wercker.png' border='0' alt="wercker" />

