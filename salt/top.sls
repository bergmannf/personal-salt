base:
  '*':
    - git
    - bash
    - tmux
  # - ssh -> Can probably be part of the user setup using the user formula
  # - gpg
  'roles:desktop':
    - match: grain
    - i3wm
  'roles:backup':
    - match: grain
    - syncthing
  'roles:music-server':
    - match: grain
    - mpd
    - icecast
    - beets
  'roles:music-client':
    - match: grain
    - gmpc
  'roles:games':
    - match: grain
    - playonlinux
    - steam
  'roles:rpg':
    - match: grain
    - maptool
    - pcgen
