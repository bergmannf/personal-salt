tmux.package:
  pkg.installed:
    - pkgs:
        - tmux

tmux.theme:
  file.managed:
    - name: /home/{{ user }}/.tmux-theme
    - source: salt://tmux/files/tmux.theme
    - makedirs: true
    - user: {{ user }}
    - group: users

tmux.config:
  file.managed:
    - name: /home/{{ user }}/.config/
    - source: salt://tmux/files/tmux.config
    - makedirs: true
    - user: {{ user }}
    - group: users
    - require:
      - user: {{ user }}
      - pkg: tmux.package
      - file: tmux.theme
