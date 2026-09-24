cask "studiozio-maximizer" do
  version "1.0.3"
  sha256 "d589be77a2d72355a86a2bd2b7d5ea70dcd9d2b5871ec61c6960e5754abecc50"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/maximizer-v#{version}/StudioZIO-Maximizer-#{version}.pkg"
  name "StudioZIO Maximizer"
  desc "Adaptive limiter held to a true-peak ceiling"
  homepage "https://www.studiozio.tech/products/maximizer/"

  livecheck do
    url :url
    regex(/^maximizer[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  # The installer declares a macOS 11.0 minimum and hostArchitectures
  # x86_64,arm64: every format is Universal.
  depends_on macos: :big_sur

  pkg "StudioZIO-Maximizer-#{version}.pkg"

  # Read from the published installer's own Distribution and PackageInfo
  # files, not guessed: the outer product receipt plus one component package
  # per format (Standalone to /Applications, AU, VST3, and AAX to
  # /Library/Application Support/Avid/Audio/Plug-Ins). Leaving the AAX receipt
  # out would keep the .aaxplugin loading in Pro Tools after `brew uninstall`.
  uninstall pkgutil: [
    "com.studiozio.maximizer.pkg",
    "com.studiozio.maximizer.pkg.aax",
    "com.studiozio.maximizer.pkg.au",
    "com.studiozio.maximizer.pkg.standalone",
    "com.studiozio.maximizer.pkg.vst3",
  ]

  # No zap stanza yet: the settings paths have not been confirmed on a machine
  # with the plug-in installed, and a wrong path is worse than none.
end
