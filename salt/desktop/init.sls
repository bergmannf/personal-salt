{% from "desktop/map.jinja" import desktop with context %}

include:
  - users

desktop.packages:
  pkg.installed:
    - pkgs:
      - {{ desktop.i3 }}
      - i3status
      - i3lock
      - conky
      - compton
      - feh
      - {{ desktop.font_awesome }}
      - redshift
      - rofi
      - {{ desktop.sensors }}

{% for user, details in pillar.get('users').items() %}
{% if 'users' in details['groups'] %}
{{ user }}.i3.config:
  file.managed:
    - name: /home/{{ user }}/.i3/config
    - source: salt://desktop/files/config
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: desktop.packages

{{ user }}.conky.exec:
  file.managed:
    - name: /home/{{ user }}/.i3/conky
    - source: salt://desktop/files/conky
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: desktop.packages

{{ user }}.conky.config:
  file.managed:
    - name: /home/{{ user }}/.i3/conkyrc
    - source: salt://desktop/files/conkyrc
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: desktop.packages
{% endif %}
{% endfor %}
