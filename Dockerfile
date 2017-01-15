FROM alpine:latest
MAINTAINER Noel Georgi <noel.georgi@reancloud.com>
EXPOSE 3306
RUN ["apk", "add", "--no-cache", "mysql"]
RUN ["rm", "-rf", "/var/lib/mysql"]
COPY ./run.sh /usr/local/bin/
RUN ["chmod", "+x", "/usr/local/bin/run.sh"]
CMD ["/usr/local/bin/run.sh"]
