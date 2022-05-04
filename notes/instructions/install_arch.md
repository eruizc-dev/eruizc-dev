# Arch installation

### Important configuration

 - Important shell alias:

    ```bash
    alias flex='neofetch'
    ```

 - Important vim plugin

    ```vim
    Plug 'eruizc-dev/vim-flex'
    ```

### Partition the drive

 1. Use fdisk
    - [Lifewire - Linux command fdisk](https://www.lifewire.com/linux-command-fdisk-4091540)

### Enable DCHP

 1. Install `dhcpcd` with arch-chroot
    - `pacman -S dhcpcd`
 2. Reboot into the system (no chroot)
 3. Start the dhcpcd service
    - `sudo systemctl dhcpcd start`
 4. Check what's your ethernet interface
    - `ip addr`
 5. Configure dhcp on that interface, or whatever
    - `dhcpcd enp34s0`

### Font

 - Install fonts:
    - [Arch Wiki - Fonts](https://wiki.archlinux.org/index.php/Fonts)
 - List fonts
    `fc-list`

### Window Manager

 1. Install xorg (the entire group)
    - `pacman -S xorg`
 2. Install drivers for your gpu
    - [Arch Wiki - Xorg: Installation](https://wiki.archlinux.org/index.php/Xorg#Installation)
 3. Install your window manager
    - `pacman -S awesome`
 4. It may have some dependencies...
    - `pacman -S xterm`
 5. Add your wm to `.xinitrc`
    - `echo "exec awesome" > .xinitrc`
 6. Launch xorg
    - `startx`

### Audio

 1. You wanna install `alsa-utils` package as mentioned in the Wiki
    - [Arch Wiki - Advanced Linux Sound Architecture: Installation](https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture#Installation)
 2. Ignore all config of alsamix, you need pulseaudio
    - `sudo pacman -S pulseaudio pulseaudio-alsa`
 3. Pretty cool to fix issues:
    - [Pauvcontrol](https://aur.archlinux.org/packages/pavucontrol-git/)

My issues:

 - Audio not working in some apps!!
    - I required pulseaudio.
    - Installed pulseaudio and pulseaudio-alsa.
 - Audio and mic not working after configuring pulseaudio and deconfiguring alsa!!
    - Wrong defaults.
    - Fixed with [this Stack Exchange](https://unix.stackexchange.com/a/462671).
 - Mic not working even after correct defaults!!
    - Microphone set as output device.
    - Fixed from Pauvcontrol.

### Rofi

 1. Install Rofi
 2. Add a way to execute it from win manager
 ```lua
    awful.key(
        { modkey }, "p",
        function ()
            os.execute("rofi -show run")
        end,
        {description = "show rofi", group = "launcher"},
    ),
 ```
