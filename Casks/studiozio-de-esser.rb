cask "studiozio-de-esser" do
  version "1.0.0"
  sha256 "698a5c45dc530b97bd4fc3c9f6e401bf4cbb414a435ff1d4235f6afa66e661f2"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/deesser-v#{version}/StudioZIO-De-Esser-#{version}.pkg"
  name "StudioZIO De-Esser"
  desc "Two-mode de-esser with its own gain-reduction meter"
  homepage "https://www.studiozio.tech/products/de-esser/"

  livecheck do
    url :url
    regex(/^deesser[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  # The installer declares a macOS 11.0 minimum and hostArchitectures
  # x86_64,arm64: every format is Universal.
  depends_on macos: :big_sur

  pkg "StudioZIO-De-Esser-#{version}.pkg"

  # Read from the published installer's own Distribution and PackageInfo
  # files, not guessed: the outer product receipt plus one component package
  # per format (Standalone to /Applications, AU, VST3, and AAX to
  # /Library/Application Support/Avid/Audio/Plug-Ins). Leaving the AAX receipt
  # out would keep the .aaxplugin loading in Pro Tools after `brew uninstall`.
  uninstall pkgutil: [
    "com.studiozio.deesser.pkg",
    "com.studiozio.deesser.pkg.aax",
    "com.studiozio.deesser.pkg.au",
    "com.studiozio.deesser.pkg.standalone",
    "com.studiozio.deesser.pkg.vst3",
  ]

  # No zap stanza yet: the settings paths have not been confirmed on a machine
  # with the plug-in installed, and a wrong path is worse than none.
end
