# Custom Patched Nerd Fonts

[![build](https://github.com/tprasadtp/starship-fonts/workflows/build/badge.svg)](https://github.com/tprasadtp/starship-fonts/actions?query=workflow%3Abuild)
[![License](https://img.shields.io/badge/license-MIT-orange?labelColor=313131)](https://github.com/tprasadtp/starship-fonts/blob/master/LICENSE)
![Analytics](https://ga-beacon.prasadt.com/UA-101760811-3/github/starship-fonts/?color=pink)

Currently supports following custom builds.

  - Cascadia code
  - Fantasque Sans Mono
  - FiraCode
  - Ubuntu

## Try

If you do not see symbols then you did not install the font properly. Try re-opening your terminal if you just installed the font.
```bash
# Fonts work on all shells
# This command however works only on BASH/ZSH is shells.
echo -e " \uE900  \uE901 \uE903 \uE904 \uE905 \uE906 \uE907 \uE908 \uE909 \uE90a \uE90b \uE90c"
```

## Custom Glyphs

| Type | From | To
|---|---|---
| [Cloud Services](./docs/cloud-services.png) | E900 | E90F
| [Git Service Providers](./docs/git-remotes.png) | EB00 | EB0A
| [Hashicorp](./docs/hashicorp.png) | EC00 | EC06
| [OS Logos](./docs/os-logos.png) | EC20 | EC35
| [Other software](./docs/other-software.png) | EE00 | EE0E

## Build

```bash
make prepare
make all
```

## Thanks

- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
- [Cascadia Code](https://github.com/microsoft/cascadia-code)
