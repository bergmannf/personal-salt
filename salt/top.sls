base:
  '*':
    - git
    - bash
  # - ssh -> Can probably be part of the user setup using the user formula
  # - gpg
  'role:desktop':
    - match:grain
    - i3wm
    - conky
    - rofi
  'role:backup':
    - match:grain
    - syncthing
  'role:music-server':
    - match:grain
    - mpd
    - icecast
    - beets
  'role:music-client':
    - match:grain
    - gmpc
  'role:games':
    - match:grain
    - playonlinux
    - steam
  'role:rpg':
    - match:grain
    - maptool
    - pcgen
