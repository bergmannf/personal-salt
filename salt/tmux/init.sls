include:
  - users

tmux.package:
  pkg.installed:
    - pkgs:
        - tmux

{% for user, details in pillar.get('users', {}).items() %}
{% if 'users' in details['groups'] %}
tmux.theme:
  file.managed:
    - name: /home/{{ user }}/.tmux-theme
    - source: salt://tmux/files/tmux.theme
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: tmux.package

tmux.config:
  file.managed:
    - name: /home/{{ user }}/.tmux.conf
    - source: salt://tmux/files/tmux.conf
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: tmux.package
      - file: tmux.theme
{% endif %}
{% endfor %}
