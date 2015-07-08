# Elastic Search SALT State File
#

{%- from 'elasticsearch/settings.sls' import elasticsearch with context %}

include:
  - sun-java
  - sun-java.env

{%- if elasticsearch.from_pkg_repo %}
elastic-repo:
  pkgrepo.managed:
    - humanname: elasticsearch
    - baseurl: {{ elasticsearch.pkg_repo_url }}
    - gpgcheck: 0

elastic-install:
  pkg.installed:
    - name: elasticsearch
    - require:
      - pkgrepo: elastic-repo
{%- else %}
elastic-install:
  pkg.installed:
    - version: {{ elasticsearch.version }}
    - sources:
      - elasticsearch: {{ elasticsearch.single_pkg_url }}
{%- endif %}

# Required for services command environment reset
elastic-service-environment:
  file.append:
    - name: /etc/sysconfig/elasticsearch
    - text: JAVA_HOME=/usr/lib/java
    - require:
      - pkg: elastic-install

elastic-start:
  service.running:
    - name: elasticsearch
    - require:
      - pkg: elastic-install
      - file: elastic-service-environment
      - sls: sun-java.env

elastic-enable:
  service.enabled:
    - name: elasticsearch
    - require:
      - pkg: elastic-install
