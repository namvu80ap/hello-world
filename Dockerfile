FROM oracle/graalvm-ce:19.0.0 as graalvm
COPY . /home/app/hello-world
WORKDIR /home/app/hello-world
RUN gu install native-image
RUN native-image --no-server -cp build/libs/hello-world-*.jar

FROM frolvlad/alpine-glibc
EXPOSE 8080
COPY --from=graalvm /home/app/hello-world .
ENTRYPOINT ["./hello-world"]
