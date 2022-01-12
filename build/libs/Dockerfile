#jdk with ubuntu
FROM openjdk:11-bullseye
COPY com.example*.jar /chat.jar
COPY dump.rdb /dump.rdb
#COPY RedisScript.sh /RedisScript.sh
# install redis server
RUN apt-get update && apt-get install redis-server -y
#CMD ["redis-server"]
#CMD ["nohup", "./RedisScript.sh" ]
CMD ["java", "-jar", "/chat.jar" ]



