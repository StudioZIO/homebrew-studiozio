cask "studiozio-mixrack" do
  version "1.0.0"
  sha256 "9452403bf1150bd4188cbfe550f1ad0840087c68fe0b56f5036f08e17b4a4fda"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/mixrack-v#{version}/StudioZIO-Mixrack-#{version}.pkg"
  name "StudioZIO Mixrack"
  desc "Modular mixing environment that brings essential processing into one rack"
  homepage "https://studioziomixrack.vercel.app/"

  livecheck do
    url :url
    regex(/^mixrack[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  # The installer declares a macOS 11.0 minimum and hostArchitectures
  # x86_64,arm64: every format is Universal.
  depends_on :macos

  pkg "StudioZIO-Mixrack-#{version}.pkg"

  # Read from the installer's own Distribution (product id) and PackageInfo
  # files: four component receipts plus the product receipt the installer
  # registers alongside them. Leaving the AAX receipt out would keep the
  # .aaxplugin loading in Pro Tools after `brew uninstall`.
  uninstall pkgutil: [
    "com.studiozio.ziomixrack.pkg",
    "com.studiozio.ziomixrack.pkg.aax",
    "com.studiozio.ziomixrack.pkg.au",
    "com.studiozio.ziomixrack.pkg.standalone",
    "com.studiozio.ziomixrack.pkg.vst3",
  ]

  # No zap stanza yet: the settings paths have not been confirmed on a machine
  # with the plug-in installed, and a guessed path either does nothing or
  # removes the wrong file.
end
