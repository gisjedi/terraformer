sudo apt install certbot python3-certbot-dns-route53

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bashrc

brew install terragrunt terraform awscli certbot

# must retrieve openshift-install and oc clis
# openshift-install should be pinned to desired version of OCP to install
OPENSHIFT_INSTALL=https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable-4.6
curl $OPENSHIFT_INSTALL/openshift-install-linux.tar.gz | tar xvz openshift-install 
sudo mv openshift-install /usr/local/bin/ 
curl $OPENSHIFT_INSTALL/openshift-client-linux.tar.gz | tar xvz oc 
sudo mv oc /usr/local/bin/

# Generate
/usr/bin/certbot certonly --agree-tos -m jpow3@pm.me --dns-route53 -d ocp.kubic-blacksky.com -d api.ocp.kubic-blacksky.com -d '*.apps.ocp.kubic-blacksky.com' --config-dir certs --work-dir certs --logs-dir certs
