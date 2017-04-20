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

scala.package:
  pkg.installed:
    - sources:
        - scala: {{ scala.pkg_url }}

sbt.package:
  pkg.installed:
    - pkgs:
        - {{ scala.jdk }}
        - sbt

ammonite.repl:
  file.managed:
    - name: /usr/local/bin/amm
    - source: https://git.io/vMF2M
    - source_hash: sha256=4084101271944253d0528587d437e9f15c2661c3289b50bb69925a3077c3fc39
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

{{ user }}.sbt.plugins:
  file.managed:
    - name: /home/{{ user }}/.sbt/0.13/plugins.sbt
    - text: addSbtPlugin("org.ensime" % "sbt-ensime" % "1.12.9")
    - require:
      - user: {{ user }}
      - sbt.package

{{ user }}.scala.home:
  file.append:
    - name: /home/{{ user }}/.bash_rc
    - text: export SCALA_HOME={{ scala.home }}
{% endfor %}
