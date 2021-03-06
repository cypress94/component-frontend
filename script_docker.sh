
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker run --name some-postgres -h localhost -e POSTGRES_HOST=127.0.0.1 -e POSTGRES_PORT=5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=postgres -d postgres:9.3
docker run --link some-postgres:postgres -d --name tomcat tomcat
mvn package
cp target/spring-boot-thymeleaf-1.0.war src/main/docker
docker build -t my_app_component_frontend src/main/docker
docker run --link tomcat:tomcat --link some-postgres:postgres my_app_component_frontend /bin/sh
