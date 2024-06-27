# Use the latest Tomcat image from Docker Hub
FROM docker:latest
RUN apk update && apk add --no-cache curl

# Arguments passed from buildspec.yml
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

# Install awscli to interact with AWS services
RUN apt-get update && \
    apt-get install -y awscli

# Set environment variables for AWS credentials (replace with your AWS credentials or use IAM roles)
ENV AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
ENV AWS_DEFAULT_REGION=us-east-1
# Set environment variables for Docker Hub credentials
ENV DOCKER_HUB_USER=mukesh243
ENV DOCKER_HUB_PASSWORD=243@mukesh

RUN echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_HUB_USER" --password-stdin

RUN docker pull mukesh243/tomcat:latest

# Create directory to store WAR file
RUN mkdir -p /usr/local/tomcat/webapps/myapp

# Copy WAR file from S3 bucket to webapps folder
RUN aws s3 cp s3://sample-bucket76tjrf/sample-maven/target/wwp-1.0.0.war /usr/local/tomcat/webapps/myapp/wwp-1.0.0.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
