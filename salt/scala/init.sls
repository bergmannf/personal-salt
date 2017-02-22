{% from "scala/map.jinja" import scala with context %}

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
