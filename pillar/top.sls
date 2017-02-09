base:
  '*':
    - users
  'roles:desktop':
    - match: grain
    - users.desktop
  'roles:music-server':
    - match: grain
    - users.music-server
