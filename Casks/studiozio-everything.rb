cask "studiozio-everything" do
  version "1.0.3"
  # Filled in from the installer downloaded from the published GitHub release
  # (release step B7), never from the build machine. Until then the cask refuses
  # to install: no download can match this value.
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/everything-v#{version}/StudioZIO-Everything-#{version}.pkg"
  name "StudioZIO Everything"
  desc "Every StudioZIO plug-in in one installer"
  homepage "https://www.studiozio.tech/products/everything/"

  livecheck do
    url :url
    regex(/^everything[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  # Everything installs the same component packages, with the same receipts, as
  # the seven single-product casks. Installing both would register one set of
  # files under two casks, and uninstalling either would remove the other's.
  conflicts_with cask: %w[
    studiozio-compressor
    studiozio-de-esser
    studiozio-inflator
    studiozio-mastering-suite
    studiozio-maximizer
    studiozio-mixrack
    studiozio-tempo-delay
  ]
  # Read from the installer's own Distribution: hostArchitectures x86_64,arm64
  # and a macOS 11.0 minimum, so no arch line belongs here. Six of the seven
  # plug-ins are Universal. Tempo Delay is Apple Silicon only and needs macOS 12;
  # the installer itself deselects and disables it on Intel Macs and on macOS 11.
  depends_on :macos

  pkg "StudioZIO-Everything-#{version}.pkg"

  # Twenty-nine receipts, read out of the 1.0.3 package: the product receipt
  # (Distribution product id) and the four component receipts of each of the
  # seven plug-ins (PackageInfo identifiers). Missing any one of them leaves a
  # plug-in installed and still loading after `brew uninstall`. The mixed case
  # in the Tempo Delay identifiers is deliberate; pkgutil matches them exactly.
  uninstall pkgutil: [
    "com.studiozio.compressor.pkg.aax",
    "com.studiozio.compressor.pkg.au",
    "com.studiozio.compressor.pkg.standalone",
    "com.studiozio.compressor.pkg.vst3",
    "com.studiozio.deesser.pkg.aax",
    "com.studiozio.deesser.pkg.au",
    "com.studiozio.deesser.pkg.standalone",
    "com.studiozio.deesser.pkg.vst3",
    "com.studiozio.everything.pkg",
    "com.studiozio.inflator.pkg.aax",
    "com.studiozio.inflator.pkg.au",
    "com.studiozio.inflator.pkg.standalone",
    "com.studiozio.inflator.pkg.vst3",
    "com.studiozio.masteringsuite.pkg.aax",
    "com.studiozio.masteringsuite.pkg.au",
    "com.studiozio.masteringsuite.pkg.standalone",
    "com.studiozio.masteringsuite.pkg.vst3",
    "com.studiozio.maximizer.pkg.aax",
    "com.studiozio.maximizer.pkg.au",
    "com.studiozio.maximizer.pkg.standalone",
    "com.studiozio.maximizer.pkg.vst3",
    "com.StudioZIO.StudioZIOTempoDelay.aax.pkg",
    "com.StudioZIO.StudioZIOTempoDelay.app.pkg",
    "com.StudioZIO.StudioZIOTempoDelay.component.pkg",
    "com.StudioZIO.StudioZIOTempoDelay.vst3.pkg",
    "com.studiozio.ziomixrack.pkg.aax",
    "com.studiozio.ziomixrack.pkg.au",
    "com.studiozio.ziomixrack.pkg.standalone",
    "com.studiozio.ziomixrack.pkg.vst3",
  ]

  # The single-product casks leave the shared ~/Library/Application
  # Support/StudioZIO folder alone, because removing it with one of them would
  # take another product's data. This cask installed every StudioZIO plug-in,
  # so zapping it leaves none of them behind to lose data. Only the two
  # .settings files confirmed on a machine are listed.
  zap trash: [
    "~/Library/Application Support/StudioZIO",
    "~/Library/Preferences/StudioZIO Mastering Suite.settings",
    "~/Library/Preferences/StudioZIOTempoDelay.settings",
  ]
end
