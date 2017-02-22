{% from "scala/map.jinja" import scala with context %}

include:
  - users

sbt.repo:
  {% if grains.get('os') in ["Ubuntu", "Debian"] %}
  pkgrepo.managed:
    - humanname: SBT repository
    - name: deb https://dl.bintray.com/sbt/debian /
    - keyserver: keyserver.ubuntu.com
    - keyid: 2EE0EA64E40A89B84B2DF73499E82A75642AC823
    - require_in:
      - pkg: sbt.package
  {% else %}
  pkgrepo.managed:
    - name: bintray--sbt-rpm
    - baseurl: http://dl.bintray.com/sbt/rpm
    - gpgcheck: 0
    - repo_gpgcheck: 0
    - require_in:
      - pkg: sbt.package
  {% endif %}

sbt.package:
  pkg.installed:
    - pkgs:
        - {{ scala.jdk }}
        - sbt

ammonite.repl:
  file.managed:
    - name: /usr/local/bin/amm
    - source: https://git.io/vMF2M
    - source_hash: md5=07143cdf89e94b0a957f5656193d88d7
    - user: root
    - group: root
    - mode: 0755

{% for user, details in pillar.get('users', {}).items() if 'users' in details['groups'] %}
{{ user }}.ammonite.config:
  file.managed:
    - name: /home/{{ user }}/.ammonite/predef.sc
    - source: salt://scala/files/ammonite.predef
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - ammonite.repl
{% endfor %}
