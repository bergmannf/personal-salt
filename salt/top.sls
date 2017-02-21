base:
  '*':
    - git
    - bash
    - tmux
  # - ssh -> Can probably be part of the user setup using the user formula
  # - gpg
  'roles:desktop':
    - match: grain
    - desktop
    - emacs
    - scala
    - syncthing
  'roles:backup':
    - match: grain
    - syncthing
  'roles:music-server':
    - match: grain
    - mpd
    - beets
    # - icecast
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
