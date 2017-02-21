include:
  - users

bash.package:
  pkg.installed:
    - pkgs:
        - bash

{% for user, details in pillar.get('users', {}).items() %}
{% if 'users' in details['groups'] %}
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

{{ user }}-bashit:
  git.latest:
    - name: https://github.com/Bash-it/bash-it.git
    - target: /home/{{ user }}/.bash_it
    - user: {{ user }}
    - require:
        - user: {{ user }}
        - pkg: bash.package
        - {{ user }}-bashrc
{% endif %}
{% endfor %}

{% for user, details in pillar.get('users', {}).items() %}
{{ user }}-run-bashit:
  cmd.run:
    # The bashrc file already contains the enabling code, so no modifications
    - name: /home/{{ user }}/.bash_it/install.sh --silent --no-modify-config
    - cwd: /home/{{ user }}
    - runas: {{ user }}
    - shell: /bin/bash
    - require:
        - user: {{ user }}
        - pkg: bash.package
        - {{ user }}-bashit
{% endfor %}
