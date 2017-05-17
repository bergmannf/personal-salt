include:
  - users

zsh.package:
  pkg.installed:
    zsh

{% for user, details in pillar.get('users', {}).items() %}
{% if 'users' in details['group'] %}
zsh.zshrc:
  file.managed:
    - name: /home/{{ user }}/.zshrc
    - source: salt://zsh/files/zshrc
    - makedirs: true
    - user: {{ user }}
    - groups: users
    - require:
        - user: {{ user }}
        - pkg: zsh.package

zsh.zprofile:
  file.managed:
    - name: /home/{{ user }}/.zprofile
    - source: salt://zsh/files/zprofile
    - makedirs: true
    - user: {{ user }}
    - groups: users
    - require:
        - user: {{ user }}
        - pkg: zsh.package

zsh.theme:
  file.managed:
    - name: /home/{{ user }}/.zsh/themes/planet.zsh-theme
    - source: salt://zsh/files/planet.zsh-theme
    - makedirs: true
    - user: {{ user }}
    - groups: users
    - require:
        - user: {{ user }}
        - pkg: zsh.package
{% endif %}
{% endfor %}
