# StudioZIO Homebrew tap

Install StudioZIO's free macOS audio plug-ins from the command line.

```sh
brew tap StudioZIO/studiozio
brew trust StudioZIO/studiozio
brew install --cask studiozio-mastering-suite
brew install --cask studiozio-tempo-delay
brew install --cask studiozio-inflator
brew install --cask studiozio-maximizer
brew install --cask studiozio-compressor
brew install --cask studiozio-de-esser
```

Install only the casks you want; each one is independent.

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
| `studiozio-mastering-suite` | StudioZIO Mastering Suite 2.1.1 | AU, VST3, AAX, Standalone | macOS 11 or newer, Apple Silicon or Intel |
| `studiozio-tempo-delay` | StudioZIO Tempo Delay 4.0.1 | AU, VST3, AAX, Standalone | macOS 12 or newer, Apple Silicon only |
| `studiozio-inflator` | StudioZIO Inflator 1.0.0 | AU, VST3, AAX, Standalone | macOS 11 or newer, Apple Silicon or Intel |
| `studiozio-maximizer` | StudioZIO Maximizer 1.0.3 | AU, VST3, AAX, Standalone | macOS 11 or newer, Apple Silicon or Intel |
| `studiozio-compressor` | StudioZIO Compressor 1.0.0 | AU, VST3, AAX, Standalone | macOS 11 or newer, Apple Silicon or Intel |
| `studiozio-de-esser` | StudioZIO De-Esser 1.0.0 | AU, VST3, AAX, Standalone | macOS 11 or newer, Apple Silicon or Intel |

Plug-ins install to `/Library/Audio/Plug-Ins/Components` and
`/Library/Audio/Plug-Ins/VST3`, the AAX plug-ins to
`/Library/Application Support/Avid/Audio/Plug-Ins`; the standalone
applications go to `/Applications`. Because the installers write outside your home folder,
Homebrew will ask for your password, exactly as the installer would.

## Updating and removing

```sh
brew update && brew upgrade --cask studiozio-mastering-suite
brew uninstall --cask studiozio-mastering-suite
```

Uninstalling removes the plug-ins and the standalone application. Your own
presets and settings are left alone.

## Why a tap rather than the main Homebrew cask list

Homebrew's official cask repository accepts new software on a judgement of
notability: it looks for substantial, independently verifiable public interest
and more than one request for inclusion. StudioZIO is new and does not show
that yet. A tap is the route Homebrew's own documentation points to in that
situation, and the cask files here are the same ones that would be submitted
upstream later.

## Verifying a download yourself

The checksums in the casks are the ones published in the release notes and on
each product page, and every cask file carries its own. To check by hand:

```sh
shasum -a 256 StudioZIO-Mastering-Suite-2.1.1.pkg
# b054098c4f6565e5e469efd41554425d468830a001c9d4c531e72ab8c50f4cf1

shasum -a 256 StudioZIOTempoDelay-v4.1.0-macOS-arm64.pkg
# fa16f0c9f04f5f56e446ae06074a0f3b0a8e193fa21089e0bf92c486d197910d
```

## Links

- Products and documentation: <https://www.studiozio.tech/>
- Mastering Suite: <https://studioziomasteringsuite.vercel.app/>
- Tempo Delay: <https://www.tempodelay.tech/>
- Technical notes: <https://www.studiozio.tech/notes/>
- Bug reports: <https://github.com/StudioZIO/Support/issues>

## Licence

The cask files in this repository are released under the BSD 2-Clause licence,
matching Homebrew's own. The plug-ins themselves are separate closed-source
freeware; installing them is subject to their own terms.
