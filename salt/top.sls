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
    - syncthing
  'role:music-server':
    - mpd
    - icecast
    - beets
  'role:music-client':
    - gmpc
  'role:games':
    - playonlinux
    - steam
  'role:rpg':
    - maptool
    - pcgen                     # 
