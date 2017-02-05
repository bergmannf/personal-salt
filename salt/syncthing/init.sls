syncthing.repo:
  pkgrepo.managed:
    - humanname: Syncthing repository
    - name: deb https://apt.syncthing.net/ syncthing release
    - key_url: https://syncthing.net/release-key.txt
    - require_in:
      - pkg: syncthing.package

syncthing.package:
  pkg.installed:
    - pkgs:
      - syncthing
    - require:
      - syncthing.repo
