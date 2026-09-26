cask "studiozio-tempo-delay" do
  # From 4.0.3 the plug-ins, the installer, its receipts and the release tag all
  # carry one version, and the tag has no build label (tempo-delay-v4.0.3). The
  # superseded 4.1.0 clean-packaging and 4.0.1 AAX releases carry build labels,
  # so the anchored livecheck pattern below does not match them.
  version "4.0.3"
  sha256 "6ba310fadf4435a2929675035298b27da534d7215e2370c6b50075ab52d60330"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/tempo-delay-v#{version}/StudioZIOTempoDelay-v#{version}-macOS-arm64.pkg"
  name "StudioZIO Tempo Delay"
  desc "Tempo-synced stereo delay with independent left and right timing"
  homepage "https://www.tempodelay.tech/"

  livecheck do
    url :url
    regex(/^tempo[._-]delay[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on arch: :arm64
  # The installer declares arm64 only and a 12.0 minimum, so the cask does too;
  # without the arch line Homebrew would offer it to Intel Macs it cannot run on.
  depends_on macos: :monterey

  pkg "StudioZIOTempoDelay-v#{version}-macOS-arm64.pkg"

  # Identifiers read from the installer's own PackageInfo files. The mixed case
  # is deliberate -- pkgutil matches these exactly. The AAX receipt belongs
  # here for the same reason it does in the Mastering Suite cask: without it
  # `brew uninstall` leaves the .aaxplugin in place and still loading in
  # Pro Tools.
  uninstall pkgutil: [
    "com.StudioZIO.StudioZIOTempoDelay.aax.pkg",
    "com.StudioZIO.StudioZIOTempoDelay.app.pkg",
    "com.StudioZIO.StudioZIOTempoDelay.component.pkg",
    "com.StudioZIO.StudioZIOTempoDelay.vst3.pkg",
  ]

  # This installer registers no outer product receipt, so the four above are
  # the whole set -- read back from the 4.0.3 package itself (the same four
  # identifiers as the superseded 4.1.0 and 4.0.1 AAX builds).
  zap trash: "~/Library/Preferences/StudioZIOTempoDelay.settings"
end
