## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![](https://github.com/rmiller715/Cybersecurity-Bootcamp-Project-1/blob/master/Diagrams/Network.PNG)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YML file may be used to install only certain pieces of it, such as Filebeat.

  - [ELK install](https://github.com/rmiller715/Cybersecurity-Bootcamp-Project-1/blob/master/Ansible/Install-ELK.yml)
  - [Metricbeat playbook](https://github.com/rmiller715/Cybersecurity-Bootcamp-Project-1/blob/master/Ansible/Metricbeat-playbook.yml)
  - [Filebeat playbook](https://github.com/rmiller715/Cybersecurity-Bootcamp-Project-1/blob/master/Ansible/Filebeat-playbook.yml)

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
Load balancers help ensure environment availability through distribution of incoming data to web servers. Jump boxes allow for more easy administration of multiple systems 
and provide an additional layer between outside and internal assets.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the event logs and system metrics.
- Filbeats watch for log files. 
- Metricbeat helps you monitor your servers by collecting metrics from the system and services running on the server.

The configuration details of each machine may be found below.


| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.4   | Linux            |
| web-01   | Server         | 10.0.06           | Linux                 |
| web-02   | Server         | 10.0.07           | Linux                 |
| elk-server | Log Server   | 10.1.0.4           | Linux   |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the jump box provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:

 - my personal IP address
 - 72.46.195.191 (the load balancer's IP address)

Machines within the network can only be accessed by the Jump Box. The Elk Machine can have access from 72.46.195.191 through port 5601.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes            | 72.46.195.191    |
| load balancer | Yes     | Open |
| Web-1         | No                    |  10.0.0.6                    |
| Web-2         | No                    |  10.0.0.7                    |
| ELK Server  |    Yes     |   72.46.192.191    |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because servcies running can be limited, system installation and update can be streamlined, and processes become more replicable. 

The playbook implements the following tasks:
- installs docker, python, and the docker module.
```bash
  # Use apt module
    - name: Install docker.io
      apt:
        update_cache: yes
        name: docker.io
        state: present

  # Use apt module
    - name: Install pip3
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

  # Use pip module
    - name: Install Docker python module
      pip:
        name: docker
        state: present
```   
- increases the virtual memory on the VM that will run ELK.
```bash
  # Use command module
    - name: Increase virtual memory
      command: sysctl -w vm.max_map_count=262144
```
- uses sysctl module
```bash
  # Use sysctl module
    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: "262144"
        state: present
        reload: yes
```
- downloads and launches the docker container for elk 
```bash
# Use docker_container module
    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        published_ports:
          - 5601:5601
          - 9200:9200
          - 5044:5044
```
The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1 (10.0.0.6)
- Web-2 (10.0.0.7)

We have installed the following Beats on these machines:
- FileBeat
- Metric Beat

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._
- Filebeat is a log data shipper for local files. Installed as an agent on your servers, Filebeat monitors the log directories or specific log files, tails the files, and forwards them either to Elasticsearch or Logstash for indexing. E.g., kibana.log collects log data on the state of kibana.
- Metricbeat collects metrics and statistics on the system. E.g., cpu usage, which can be used to monitor the system health.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook, install-elk.yml, to /etc/ansible/roles.
- Update the /etc/ansible/hosts file to include the IP address for the elk server.
- Run the playbook, and navigate to http://[Elk Server Public IP]:5601/app/kibana to check that the installation worked as expected.

- _Which file is the playbook? Where do you copy it?_
The Filebeat-configuration is the playbook and you copy the /etc/ansible/file/filebeat-configuration.yml to the destination of the webserver's /etc/filebeat/filebeat.yml
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
Edit the /etc/ansible/host file to add webserver/elkserver ip addresses
- _Which URL do you navigate to in order to check that the ELK server is running?


