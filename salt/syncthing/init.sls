{% if grains.get('os') in ["Ubuntu", "Debian"] %}
syncthing.repo:
  pkgrepo.managed:
    - humanname: Syncthing repository
    - name: deb https://apt.syncthing.net/ syncthing release
    - key_url: https://syncthing.net/release-key.txt
    - require_in:
      - pkg: syncthing.package
{% endif %}

syncthing.package:
  pkg.installed:
    - pkgs:
      - syncthing
    {% if grains.get('os') in ["Ubuntu", "Debian"] %}
    - require:
      - syncthing.repo
    {% endif %}
