FROM frolvlad/alpine-glibc:alpine-3.6

#
# [ Setup Ruby ]
# Please comment out if you wanna use ruby
#
# ARG RUBY_VERSION
# ENV RUBY_VERSION 2.4.2-r0

# RUN apk add ruby=${RUBY_VERSION} \
#             ruby-rdoc=${RUBY_VERSION} \
#             ruby-irb=${RUBY_VERSION} && \
#     gem install bundler

#
# [ Set environment variables ]
#
ENV ANDROID_SDK_HOME /usr/local/android-sdk
ENV ANDROID_HOME ${ANDROID_SDK_HOME}
ENV PATH ${PATH}:${ANDROID_SDK_HOME}/tools
ENV PATH ${PATH}:${ANDROID_SDK_HOME}/tools/bin
ENV PATH ${PATH}:${ANDROID_SDK_HOME}/platform-tools
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

#
# [ Setup system ]
#
RUN apk update
RUN apk add openjdk8 bash wget
RUN apk --no-cache add ca-certificates
RUN mkdir -p ${ANDROID_SDK_HOME}

#
# [ Setup user ]
# Failed to update Android SDK tools if do not this.
# 
# RUN adduser -u 1000 -S android
# RUN chown 1000 ${ANDROID_SDK_HOME}
# USER android

#
# [ Install Android SDK Tools ]
# Download URL get by https://developer.android.com/studio/index.html#downloads
#
ARG ANDROID_SDK_ZIP
ENV ANDROID_SDK_ZIP ${ANDROID_SDK_ZIP:-https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip}
RUN wget -q ${ANDROID_SDK_ZIP} -O /tmp/android-sdk.zip && \
    unzip /tmp/android-sdk.zip -d ${ANDROID_SDK_HOME} && \
    rm -f /tmp/android-sdk.zip

#
# [ Install Android SDK ]
#
RUN yes | sdkmanager --licenses
RUN sdkmanager --update
RUN yes | sdkmanager --licenses
RUN sdkmanager "platform-tools"

# ARG ANDROID_EMULATOR_PACKAGE
# ENV ANDROID_EMULATOR_PACKAGE system-images;android-26;google_apis;x86

ARG ANDROID_COMPONENTS
ENV ANDROID_COMPONENTS ${ANDROID_COMPONENTS:-"build-tools;26.0.1 \
                                              platforms;android-26 \
                                              extras;android;m2repository \
                                              extras;google;google_play_services \
                                              extras;google;m2repository"}
RUN sdkmanager ${ANDROID_COMPONENTS}
