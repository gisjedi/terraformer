curl -L https://github.com/gruntwork-io/terragrunt/releases/download/v0.28.7/terragrunt_linux_amd64 > terragrunt
curl https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip > terraform.zip
unzip -o terraform.zip
rm terraform.zip

# must retrieve openshift-install and oc clis
# openshift-install should be pinned to desired version of OCP to install
OPENSHIFT_INSTALL=https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-4.6
curl $OPENSHIFT_INSTALL/openshift-install-linux.tar.gz | tar xvz openshift-install 
curl $OPENSHIFT_INSTALL/openshift-client-linux.tar.gz | tar xvz oc 
chmod +x terraform terragrunt oc openshift-install
sudo mv oc terraform openshift-install terragrunt /usr/local/bin/

# Unneeded if we are using Amazon Linux as CLI is pre-installed.
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# All the below is only needed in factory environment if we want to generate certs
sudo apt install certbot python3-certbot-dns-route53

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bashrc

brew install terragrunt terraform awscli certbot

# Generate Lets Encrypt certs for cluster with certbot
/usr/bin/certbot certonly --agree-tos -m jpow3@pm.me --dns-route53 -d ocp.kubic-blacksky.com -d api.ocp.kubic-blacksky.com -d '*.apps.ocp.kubic-blacksky.com' --config-dir certs --work-dir certs --logs-dir certs

