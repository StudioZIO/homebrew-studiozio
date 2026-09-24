cask "studiozio-inflator" do
  version "1.0.0"
  sha256 "c138a979cb80bd04b755ab4c308a1b0dc8ccad518d6483076e2b8a3ba05fabde"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/inflator-v#{version}/StudioZIO-Inflator-#{version}.pkg"
  name "StudioZIO Inflator"
  desc "Harmonic-enhancement stage with input and output trim"
  homepage "https://www.studiozio.tech/products/inflator/"

  livecheck do
    url :url
    regex(/^inflator[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  # The installer declares a macOS 11.0 minimum and hostArchitectures
  # x86_64,arm64: every format is Universal.
  depends_on macos: :big_sur

  pkg "StudioZIO-Inflator-#{version}.pkg"

  # Read from the published installer's own Distribution and PackageInfo
  # files, not guessed: the outer product receipt plus one component package
  # per format (Standalone to /Applications, AU, VST3, and AAX to
  # /Library/Application Support/Avid/Audio/Plug-Ins). Leaving the AAX receipt
  # out would keep the .aaxplugin loading in Pro Tools after `brew uninstall`.
  uninstall pkgutil: [
    "com.studiozio.inflator.pkg",
    "com.studiozio.inflator.pkg.aax",
    "com.studiozio.inflator.pkg.au",
    "com.studiozio.inflator.pkg.standalone",
    "com.studiozio.inflator.pkg.vst3",
  ]

  # No zap stanza yet: the settings paths have not been confirmed on a machine
  # with the plug-in installed, and a wrong path is worse than none.
end
