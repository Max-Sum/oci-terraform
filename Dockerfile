FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y curl gpg \ 
 && curl -sS https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null \
 && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bullseye main" | tee /etc/apt/sources.list.d/hashicorp.list \
 && apt-get update && apt-get install -y python3 python3-venv terraform \
 && curl -o install.sh https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh \
 && bash ./install.sh --accept-all-defaults && rm install.sh \
 && apt-get purge -y curl gpg && apt-get -y autoremove && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN adduser --system --home /app nonroot
USER nonroot
WORKDIR /app