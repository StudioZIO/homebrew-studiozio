# StudioZIO Homebrew tap

Install StudioZIO's free macOS audio plug-ins from the command line.

```sh
brew tap StudioZIO/studiozio
brew trust StudioZIO/studiozio
brew install --cask studiozio-mastering-suite
brew install --cask studiozio-tempo-delay
```

The `brew trust` line is Homebrew's own safeguard for taps outside its
official repositories: without it Homebrew refuses to run any cask from here.
It is a one-off, and it applies to this tap alone. If you would rather trust a
single cask than the whole tap, use
`brew trust --cask StudioZIO/studiozio/studiozio-mastering-suite`.

Each cask downloads the same signed and notarised `.pkg` published on the
[releases page](https://github.com/StudioZIO/StudioZIO-Releases), checks it
against the SHA-256 recorded here, and runs it. There is no account, no iLok
and no email registration at any point.

## What gets installed

| Cask | Product | Formats | Requirements |
|---|---|---|---|
| `studiozio-mastering-suite` | StudioZIO Mastering Suite 2.1.1 | AU, VST3, Standalone | macOS 11 or newer, Apple Silicon or Intel |
| `studiozio-tempo-delay` | StudioZIO Tempo Delay 4.0.1 | AU, VST3, Standalone | macOS 12 or newer, Apple Silicon only |

Plug-ins install to `/Library/Audio/Plug-Ins/Components` and
`/Library/Audio/Plug-Ins/VST3`; the standalone applications go to
`/Applications`. Because the installers write outside your home folder,
Homebrew will ask for your password, exactly as the installer would.

## Updating and removing

```sh
brew update && brew upgrade --cask studiozio-mastering-suite
brew uninstall --cask studiozio-mastering-suite
```

Uninstalling removes the plug-ins and the standalone application. Your own
presets and settings are left alone.

## Why a tap rather than the main Homebrew cask list

Homebrew's official cask repository applies an automated popularity test to
new submissions — a project needs roughly 75 stars, or 30 forks or watchers,
on its canonical repository before a cask is accepted. StudioZIO is new and
does not meet that yet, and a submission would be closed by CI rather than
read by a person. A tap is the route Homebrew's own documentation points to
in that situation, and the cask files here are the same ones that would be
submitted upstream later.

## Verifying a download yourself

The checksums in the casks are the ones published in the release notes and on
each product site. To check by hand:

```sh
shasum -a 256 StudioZIO-Mastering-Suite-2.1.1.pkg
# 97dcd2f55e317054fd15dbbee098a755623838345fc37cb89b114864d1e3da5d

shasum -a 256 StudioZIOTempoDelay-v4.0.1-macOS-arm64.pkg
# adae51020ee920d607f04e15c8db3c044c8dadd7bf3e01762dd56cc1c70072c7
```

## Links

- Products and documentation: <https://studiozio.vercel.app/>
- Mastering Suite: <https://studioziomasteringsuite.vercel.app/>
- Tempo Delay: <https://www.tempodelay.tech/>
- Technical notes: <https://studiozio.vercel.app/notes/>
- Bug reports: <https://github.com/StudioZIO/Support/issues>

## Licence

The cask files in this repository are released under the BSD 2-Clause licence,
matching Homebrew's own. The plug-ins themselves are separate closed-source
freeware; installing them is subject to their own terms.
