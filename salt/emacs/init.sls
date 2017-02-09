include:
  - users

emacs.package:
  pkg.installed:
    - pkgs:
      - emacs

{% for user, details in pillar.get('users', {}).items() %}
{% if 'users' in details['groups'] %}
spacemacs available:
  git.latest:
    - name: https://github.com/syl20bnr/spacemacs
    - target: /home/{{ user }}/.emacs.d
    - user: {{ user }}
    - require:
      - pkg: emacs.package

spacemacs config:
  file.managed:
    - name: /home/{{ user }}/.spacemacs
    - source: salt://emacs/files/spacemacs
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: emacs.package
{% endif %}
{% endfor %}
