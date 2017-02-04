include:
  - users

i3 packages:
  pkg.installed:
    - pkgs:
      - i3-wm
      - i3status
      - i3lock
      - conky
      - compton
      - feh
      - fonts-font-awesome
      - rofi
      - lm-sensors

{% for user, details in pillar.get('users').items() %}
{% if 'users' in details['groups'] %}
i3 config:
  file.managed:
    - name: /home/{{ user }}/.i3/config
    - source: salt://i3wm/files/config
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: i3 packages

conky exec:
  file.managed:
    - name: /home/{{ user }}/.i3/conky
    - source: salt://i3wm/files/conky
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: i3 packages

conky config:
  file.managed:
    - name: /home/{{ user }}/.i3/conkyrc
    - source: salt://i3wm/files/conkyrc
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: i3 packages
{% endif %}
{% endfor %}
