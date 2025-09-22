# Use the official Ubuntu image as the base. You can specify a version.
FROM ubuntu:22.04


# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive


# Update the package list and install dependencies for Nessus
RUN apt-get update && apt-get install -y --no-install-recommends \
    gdebi-core \
    sudo \
    curl \
    && rm -rf /var/lib/apt/lists/*


# Copy the Nessus .deb package into the container
# Replace the file name with the one you downloaded
COPY Nessus-10.9.3-ubuntu1604_amd64.deb /tmp/


# Install the Nessus package using gdebi to resolve dependencies
RUN gdebi -n /tmp/Nessus-10.9.3-ubuntu1110_amd64.deb


# Remove the temporary Nessus package to keep the image size small
RUN rm /tmp/Nessus-10.9.3-ubuntu1110_amd64.deb


# Expose the default Nessus web interface port
EXPOSE 8834

# Start the Nessus daemon when the container launches
CMD ["/bin/bash", "-c", "service nessusd start && tail -f /opt/nessus/var/nessus/logs/nessusd.messages"]
