include:
  - users

git.package:
  pkg.installed:
    - pkgs:
        - git

{% for user, details in pillar.get('users', {}).items() %}
{% if 'users' in details['groups'] %}
{{ user }}-gitconfig:
  file.managed:
    - name: /home/{{ user }}/.gitconfig
    - source: salt://git/files/gitconfig
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: git.package
    - defaults:
        details: {{ details }}
{% endif %}
{% endfor %}
