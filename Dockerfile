FROM maven:3-jdk-8-alpine AS build
#RUN addgroup -S appgroup && adduser -S zorki -G appgroup
#USER zorki
ADD . /my-app
WORKDIR /my-app
RUN mvn compile
RUN mvn package

FROM openjdk:8-jdk-alpine
ARG fullname
RUN addgroup -S appgroup && adduser -S zorki -G appgroup
USER zorki
COPY --from=build /my-app/target/${fullname}.jar ${fullname}.jar
ARG fulljar=${fullname}.jar
RUN echo ${fulljar}
#CMD exec java -cp $fulljar com.mycompany.app.App
RUN java -cp ${fulljar} com.mycompany.app.App
CMD ["java","-cp", "${fulljar}", "com.mycompany.app.App"]
