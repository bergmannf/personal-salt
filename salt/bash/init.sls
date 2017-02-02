include:
  - users

bash.package:
  pkg.installed:
    - pkgs:
        - bash

{% for user, details in pillar.get('users', {}).items() %}
{{ user }}-bashrc:
  file.managed:
    - name: /home/{{ user }}/.bashrc
    - source: salt://bash/files/bashrc
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
        - user: {{ user }}
        - pkg: bash.package
    - defaults:
        details: {{ details }}
{% endfor %}

{% for user, details in pillar.get('users', {}).items() %}
{{ user }}-profile:
  file.managed:
    - name: /home/{{ user }}/.profile
    - source: salt://bash/files/profile
    - template: jinja
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
        - user: {{ user }}
        - pkg: bash.package
    - defaults:
        details: {{ details }}
{% endfor %}

{% for user, details in pillar.get('users', {}).items() %}
{{ user }}-bashit:
  git.latest:
    - name: https://github.com/Bash-it/bash-it.git
    - target: /home/{{ user }}/.bash_it
    - user: {{ user }}
    - require:
        - user: {{ user }}
        - pkg: bash.package
        - {{ user }}-bashrc
{% endfor %}

# The bashrc file already contains the enabling code, so this is not needed
# {% for user, details in pillar.get('users', {}).items() %}
# {{ user }}-run-bashit:
#   cmd.run:
#     - name: /home/{{ user }}/.bashit/install.sh --silent
#     - cwd: /home/{{ user }}
#     - runas: {{ user }}
#     - shell: /bin/bash
#     - require:
#         - user: {{ user }}
#         - pkg: bash.package
#         - {{ user }}-bashit
# {% endfor %}
