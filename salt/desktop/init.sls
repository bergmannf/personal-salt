include:
  - users

desktop packages:
  pkg.installed:
    - pkgs:
      - i3-wm
      - i3status
      - i3lock
      - conky
      - compton
      - feh
      - fonts-font-awesome
      - redshift
      - rofi
      - lm-sensors

{% for user, details in pillar.get('users').items() %}
{% if 'users' in details['groups'] %}
i3 config:
  file.managed:
    - name: /home/{{ user }}/.i3/config
    - source: salt://desktop/files/config
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: desktop packages

conky exec:
  file.managed:
    - name: /home/{{ user }}/.i3/conky
    - source: salt://desktop/files/conky
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: desktop packages

conky config:
  file.managed:
    - name: /home/{{ user }}/.i3/conkyrc
    - source: salt://desktop/files/conkyrc
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: desktop packages
{% endif %}
{% endfor %}
