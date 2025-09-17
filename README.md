There's some game preservation related applications that I wanted to package, but didn't feel that they each deserved having their own repository.

Notes:
- PRs are welcome!
- I have not been able to test this on a system that isn't `x86_64-linux`, so I have it hardcoded. 
- All notes here are likely correct as of latest edit, but no promises are made.
  - If you require a more recent version than what is provided in this flake, you will likely have to do that process yourself.

## Included projects:
- [Redumper](https://github.com/superg/redumper) - "Low level CD dumper utility"
  - `redumper`
    - Defaults to `redumper-release`.
  - `redumper-release`
    - Latest commit build, as built by GitHub Actions, and patched locally for use on Nix.
  - `redumper-git`
    - Using latest commit.

- [NDecrypt](https://github.com/SabreTools/NDecrypt) - "Cartridge encrypt/decrypt"
  - `ndecrypt`
    - Defaults to `ndecrypt-release`
  - `ndecrypt-bin`
    - Latest release build, as built by GitHub Actions, and patched locally for use on Nix.
  - `ndecrypt-git`
    - Using latest commit.
  - `ndecrypt-release`
    - Using release commit.

  - [SabreTools](https://github.com/SabreTools/SabreTools) - "DAT management tool with advanced editing and sorting features"
  - `sabretools`
    - Defaults to `sabretools-release`
  - `sabretools-release`
    - Using release commit.
  - `sabretools-git`
    - Using latest commit.

  - [UnshieldSharp](https://github.com/mnadareski/UnshieldSharp) - "Port of Unshield to C#"
  - `unshieldsharp`
    - Defaults to `unshieldsharp-release`
  - `unshieldsharp-release`
    - Using release commit.
  - `unshieldsharp-git`
    - Using latest commit.

  - [SabreTools.Serialization](https://github.com/SabreTools/SabreTools.Serialization) - Libraries that includes two useful binaries
    - `serialization`
      - Defaults to `serialization-release`
    - `serialization-release`
      - Using release tag.
    - `serialization-git`
      - Using latest commit.

  - [BinaryObjectScanner](https://github.com/SabreTools/BinaryObjectScanner) - "C# protection, packer, and archive scanning library"
    - `binaryobjectscanner`
      - Defaults to `binaryobjectscanner-git`
    - `binaryobjectscanner-git`
      - Using latest commit.

### DiscImageCreator
- [DiscImageCreator](https://github.com/saramibreak/DiscImageCreator) - "disc (CD, GD, DVD, HD-DVD, BD, GC/Wii, XBOX, XBOX 360) and disk (Floppy, MO, USB etc) image creation tool"
  - `discimagecreator`
    - Defaults to `dic-release-full`.
  - `dic-release`
    - Just DiscImageCreator (using Release commit).
  - `dic-release-full`
    - DiscImageCreator (using Release commit), DVDAuth, EccEdc, and Unscrambler.
  - `dic-git`
    - Just DiscImageCreator (using latest commit).
  - `dic-git-full`
    - DiscImageCreator (using Release commit), DVDAuth, EccEdc, and Unscrambler.

- [DVDAuth](https://github.com/saramibreak/DVDAuth) (by saramibreak) - "This is CSS or CPPM or CPRM authentication tool"
  - `dic-dvdauth`
    - Latest release commit.

- [EccEdc](https://github.com/saramibreak/EccEdc) (by saramibreak) - "checks or fix user data of the 2048 byte per sector of CD by using ecc/edc"
  - `dic-eccedc`
    - Latest release commit, which also happens to be the latest repository commit.

- [Unscrambler](https://github.com/saramibreak/unscrambler) (by saramibreak) - "unscramble not standard IVs scrambled DVDs thru bruteforce, intended for Gamecube/WII Optical Disks."
  - `dic-unscrambler`
    - Latest release commit.
