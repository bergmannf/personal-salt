include:
  - users

mpd.package:
  pkg.installed:
    - pkgs:
      - mpd

mpd.config:
  file.managed:
    - name: /etc/mpd.conf
    - source: salt://mpd/files/config
    - user: mpd
    - group: users
    - require:
      - pkg: mpd.package

mpd.service:
  service.running:
    - name: mpd
    - enable: True
    - reload: True
