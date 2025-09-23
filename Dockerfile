FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    libpcap0.8 \
    && rm -rf /var/lib/apt/lists/*

# Download Nessus (replace with the current version & package)
RUN wget https://downloads.nessus.org/nessus3dl.php?file=Nessus-10.7.0-ubuntu1110_amd64.deb&licence_accept=yes -O /tmp/nessus.deb \
    && dpkg -i /tmp/nessus.deb \
    && rm /tmp/nessus.deb

# Expose Nessus web interface port
EXPOSE 8834

# Persistent volume for configs, licenses, and scan data
VOLUME ["/opt/nessus/"]

# Default entrypoint
CMD ["/bin/bash", "-c", "/bin/systemctl start nessusd && tail -f /opt/nessus/var/nessus/logs/nessusd.messages"]
