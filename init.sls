# Elastic Search SALT State File
#

include:
  - sun-java
  - sun-java.env

elastic-repo:
  pkgrepo.managed:
    - humanname: elasticsearch
    - baseurl: http://packages.elastic.co/elasticsearch/1.6/centos 
    - gpgcheck: 0

elastic-install:
  pkg.installed:
    - name: elasticsearch
  require:
    - pkgrepo: elastic-repo

elastic-start:
  service.running:
    - name: elasticsearch
  require:
    - pkg: elastic-install

elastic-enable:
  service.enabled:
    - name: elasticsearch
  require:
    - pkg: elastic-install

