include:
  - users

beets.package:
  pkg.installed:
    - pkgs:
      - beets

beets.config:
  file.managed:
    - name: /home/beets/.config/beets/config.yaml
    - source: salt://beets/files/config
    - makedirs: True
    - user: beets
    - group: users
