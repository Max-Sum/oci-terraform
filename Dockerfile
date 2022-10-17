FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y curl python3 python3-venv unzip  \
 && curl -o install.sh https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh \
 && bash ./install.sh --accept-all-defaults && rm install.sh \
 && curl -o terraform.zip https://releases.hashicorp.com/terraform/1.3.2/terraform_1.3.2_linux_$(dpkg --print-architecture).zip \
 && unzip terraform.zip && mv terraform /usr/bin/ && rm terraform.zip \
 && apt-get purge -y curl gpg unzip && apt-get -y autoremove && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN adduser --system --home /app nonroot
USER nonroot
WORKDIR /app
