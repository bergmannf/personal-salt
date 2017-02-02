base:
  '*':
    - git
  # - tmux
  #   - ssh
  #   - gpg
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
