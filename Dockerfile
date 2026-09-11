FROM ubuntu:latest

LABEL author="NextKodeSchool"
LABEL application="wavecafe"
LABEL environment="development"
LABEL team="devops"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install apache2 wget unzip -y

# Download the website template
RUN wget https://www.tooplate.com/zip-templates/2121_wave_cafe.zip

# Extract the website template
RUN unzip 2121_wave_cafe.zip

# Copy website files to Apache web root
RUN cp -r 2121_wave_cafe/* /var/www/html/

# Expose port 80 for HTTP web traffic
EXPOSE 80

# Start and Run the Apache web server in the foreground
CMD ["apachectl", "-D", "FOREGROUND"]
