newhn=$(hostname -f)
admin_pass=$(grep initial_admin_password /etc/foreman-installer/scenarios.d/satellite-answers.yaml | awk '{for (i=2; i<=NF; i++) print $i}')
hostnamectl set-hostname satellite.example.com
sed -i "s/satellite-new/$(hostname -f)/" /etc/hosts
sed -i "s/192.168.0.11/$(facter ipaddress)/" /etc/hosts
dnf install -y --disableplugin foreman-protector podman
mkdir /etc/letsencrypt /var/lib/letsencrypt || true
podman run -it --rm --name certbot -p 80:80 -p 443:443 -v "/etc/letsencrypt:/etc/letsencrypt:z" -v "/var/lib/letsencrypt:/var/lib/letsencrypt:z" certbot/certbot --standalone certonly --agree-tos -n -m noreply@redhat.com -d ${newhn}
satellite-change-hostname -y --skip-dns ${newhn} --username admin --password ${admin_pass} -c /etc/letsencrypt/live/${newhn}/cert.pem -k /etc/letsencrypt/live/${newhn}/privkey.pem
