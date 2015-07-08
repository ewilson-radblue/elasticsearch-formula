{%- set p  = salt['pillar.get']('elasticsearch', {}) %}
{%- set pc = p.get('config', {}) %}
{%- set g  = salt['grains.get']('elasticsearch', {}) %}
{%- set gc = g.get('config', {}) %}

{%- set from_pkg_repo  = p.get('from_pkg_repo', true) %}
{%- set version        = p.get('version', '') %}
{%- set pkg_repo_url   = p.get('pkg_repo_url', 'http://packages.elastic.co/elasticsearch/1.6/centos') %}
{%- set single_pkg_url = p.get('single_pkg_url', '') %}

{%- set elasticsearch = {} %}
{%- do elasticsearch.update({
                        'from_pkg_repo'  : from_pkg_repo,
                        'version'        : version,
                        'pkg_repo_url'   : pkg_repo_url,
                        'single_pkg_url' : single_pkg_url
                      }) %}
