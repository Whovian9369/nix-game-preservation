There's some game preservation related applications that I wanted to package, but didn't feel that they each deserved having their own repository.

Notes:
- I have not been able to test this on a system that isn't `x86_64-linux`, so I have it hardcoded. 

Included projects:
- [Redumper](https://github.com/superg/redumper) - "Low level CD dumper utility"
  - `redumper`
    - Defaults to `redumper-bin`
  - `redumper-bin`
    - Latest commit build, as built by GitHub Actions, and patched locally for use on Nix.
  - `redumper-git`
    - Using latest commit
- [DiscImageCreator](https://github.com/saramibreak/DiscImageCreator) - "disc (CD, GD, DVD, HD-DVD, BD, GC/Wii, XBOX, XBOX 360) and disk (Floppy, MO, USB etc) image creation tool"
  - `discimagecreator`
    - Defaults to `dic-release-full`
  - `dic-release`
    - Just DiscImageCreator (using Release commit)
  - `dic-release-full`
    - DiscImageCreator (using Release commit) and EccEdc (see below)
  - `dic-git`
    - Just DiscImageCreator (using latest commit)
  - `dic-git-full`
    - DiscImageCreator (using latest commit) and EccEdc (see below)
- [EccEdc](https://github.com/saramibreak/EccEdc) (by saramibreak) - "checks or fix user data of the 2048 byte per sector of CD by using ecc/edc"
  - `dic-eccedc`
    - Latest release commit, which also happens to be the latest repository commit.
