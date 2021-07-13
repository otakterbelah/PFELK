#/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install gnupg -y
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update
sudo add-apt-repository ppa:maxmind/ppa
sudo apt install geoipupdate -y
sudo apt install elasticsearch; sudo apt install kibana; sudo apt install logstash -y
sudo wget -q -N https://raw.githubusercontent.com/pfelk/pfelk/main/etc/kibana/kibana.yml -P /etc/kibana/
sudo wget -q -N https://raw.githubusercontent.com/pfelk/pfelk/main/etc/logstash/pipelines.yml -P /etc/logstash/
sudo mkdir -p /etc/pfelk/{conf.d,config,logs,databases,patterns,scripts,templates}
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/conf.d/01-inputs.conf -P /etc/pfelk/conf.d/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/conf.d/02-types.conf -P /etc/pfelk/conf.d/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/conf.d/03-filter.conf -P /etc/pfelk/conf.d/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/conf.d/05-apps.conf -P /etc/pfelk/conf.d/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/conf.d/20-interfaces.conf -P /etc/pfelk/conf.d/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/conf.d/30-geoip.conf -P /etc/pfelk/conf.d/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/conf.d/45-cleanup.conf -P /etc/pfelk/conf.d/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/conf.d/50-outputs.conf -P /etc/pfelk/conf.d/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/conf.d/35-rules-desc.conf -P /etc/pfelk/conf.d/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/conf.d/36-ports-desc.conf -P /etc/pfelk/conf.d/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/patterns/pfelk.grok -P /etc/pfelk/patterns/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/patterns/openvpn.grok -P /etc/pfelk/patterns/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/databases/private-hostnames.csv -P /etc/pfelk/databases/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/databases/rule-names.csv -P /etc/pfelk/databases/
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/databases/service-names-port-numbers.csv -P /etc/pfelk/databases/
sudo mkdir -p /etc/pfelk/logs
sudo wget https://raw.githubusercontent.com/pfelk/pfelk/main/etc/pfelk/scripts/error-data.sh -P /etc/pfelk/scripts/
sudo chmod +x /etc/pfelk/scripts/error-data.sh
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl enable kibana.service
sudo /bin/systemctl enable logstash.service
systemctl start elasticsearch.service 
systemctl start kibana.service
systemctl start logstash.service
