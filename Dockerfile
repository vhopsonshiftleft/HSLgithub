FROM adoptopenjdk/openjdk8 

# Capture build arguments
ARG ORG
ARG TOKEN
ARG AGENT

# Set environment variables for the running container
ENV SHIFTLEFT_ORG_ID=$ORG
ENV SHIFTLEFT_ACCESS_TOKEN=$TOKEN
ENV SHIFTLEFT_SEC_COLLECT_ATTACK_INFO=$AGENT

# collect ShiftLeft tools, and target JAR
ADD https://cdn.shiftleft.io/download/sl /tmp
COPY target/hello-shiftleft-0.0.1.jar /tmp
COPY shiftleft.json /tmp

# adjust the permissions for the copied files
RUN chmod +x /tmp/sl
RUN chmod +r /tmp/shiftleft.json

# expose necessary ports
EXPOSE 8081

# execute run
CMD cd tmp ; ./sl run --app HSL --java -- java -Dshiftleft.sec.collect.attack.info=true -jar hello-shiftleft-0.0.1.jar
