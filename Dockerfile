FROM ubuntu:bionic

RUN dpkg --add-architecture i386

RUN apt-get clean && apt-get update && apt-get upgrade -y
RUN apt-get install -y libc6:i386 libstdc++6:i386 glibc-doc:i386 gcc-5-base:i386 gcc-6-base:i386 libgcc1:i386 zip unzip openjdk-8-jdk ant lib32z1 adb phantomjs wget git

RUN mkdir -p /opt/appengine && wget --no-verbose -O /tmp/appengine.zip https://storage.googleapis.com/appengine-sdks/featured/appengine-java-sdk-1.9.68.zip
RUN unzip -o /tmp/appengine.zip && mv appengine-java-sdk-1.9.68 /opt/appengine/

RUN update-java-alternatives -s java-1.8.0-openjdk-amd64

RUN mkdir /home/Text2App

RUN useradd Text2App
RUN chown -R Text2App:Text2App /home/Text2App
RUN chmod -R 755 /home/Text2App

COPY ./appinventor-sources /home/Text2App/

WORKDIR /home/Text2App/appinventor
RUN git config --global --add safe.directory /home/Text2App

RUN ant MakeAuthKey
RUN git submodule update --init
RUN ant

# RUN cat <<EOF > /usr/local/bin/start_appinventor ant RunLocalBuildServer &> buildserver.log & BUILDSERVER=$! /opt/appengine/appengine-java-sdk-1.9.68/bin/dev_appserver.sh -p 8888 -a 0.0.0.0 appengine/build/war kill -9 -- -$BUILDSERVER EOF
# RUN chmod +x /usr/local/bin/start_appinventor

USER Text2App
CMD tail -f /dev/null