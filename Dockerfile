FROM ubuntu:16.04

# Download URL get by https://developer.android.com/studio/index.html#downloads
ARG ANDROID_SDK_ZIP
ENV ANDROID_SDK_ZIP ${ANDROID_SDK_ZIP:-https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip}
# ENV ANDROID_SDK_ZIP https://dl.google.com/android/repository/tools_r25.2.3-linux.zip

#
# [ Set environment variables ]
#
ENV ANDROID_SDK_HOME /usr/local/android-sdk
ENV ANDROID_HOME ${ANDROID_SDK_HOME}
ENV PATH ${PATH}:${ANDROID_SDK_HOME}/tools
ENV PATH ${PATH}:${ANDROID_SDK_HOME}/tools/bin
ENV PATH ${PATH}:${ANDROID_SDK_HOME}/platform-tools
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

#
# [ Setup system ]
#
RUN apt-get update
RUN apt-get install -y openjdk-8-jdk wget zip
RUN mkdir -p ${ANDROID_SDK_HOME}

#
# [ Install Android SDK Tools ]
#
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

ARG ANDROID_COMPONENTS
ENV ANDROID_COMPONENTS ${ANDROID_COMPONENTS:-"build-tools;26.0.1 \
                                              platforms;android-26 \
                                              extras;android;m2repository \
                                              extras;google;google_play_services \
                                              extras;google;m2repository"}
RUN sdkmanager ${ANDROID_COMPONENTS}
