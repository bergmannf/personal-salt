users:
  florian:
    fullname: Testuser Desktop
    uid: 1001
    gid: 1001
    email: testeruser@localhost.desktop
    sudouser: true
    groups:
      - users

monitors:
  DisplayPort4:
    id: 'DisplayPort4'
    resolution: '2560x1440'
    orientation: '--right-of'
    orientation_target: 'DVI-1'
    target: 'DVI-1'
    dpi: '123'
    primary: true
  DVI-1:
    id: 'DVI-1'
    resolution: '1920x1080'
