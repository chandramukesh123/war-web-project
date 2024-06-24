# Use the latest Tomcat image from Docker Hub
FROM tomcat:latest

# Install awscli to interact with AWS services
#RUN apt-get update && \
#apt-get install -y awscli

# Set environment variables for AWS credentials (replace with your AWS credentials or use IAM roles)
#ENV AWS_ACCESS_KEY_ID=fghj
#ENV AWS_SECRET_ACCESS_KEY=+QwulMJeKlR52Xuusg8uqWhgfg
#ENV AWS_DEFAULT_REGION=us-east-1

# Create directory to store WAR file
RUN mkdir -p /usr/local/tomcat/webapps/myapp

# Copy WAR file from S3 bucket to webapps folder
RUN aws s3 cp s3://sample-bucket76tjrf/sample-maven/target/wwp-1.0.0.war /usr/local/tomcat/webapps/myapp/wwp-1.0.0.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
