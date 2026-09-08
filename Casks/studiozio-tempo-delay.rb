cask "studiozio-tempo-delay" do
  version "4.0.1"
  sha256 "adae51020ee920d607f04e15c8db3c044c8dadd7bf3e01762dd56cc1c70072c7"

  url "https://github.com/StudioZIO/StudioZIO-Releases/releases/download/tempo-delay-v#{version}/StudioZIOTempoDelay-v#{version}-macOS-arm64.pkg",
      verified: "github.com/StudioZIO/StudioZIO-Releases/"
  name "StudioZIO Tempo Delay"
  desc "Tempo-synced stereo delay with independent left and right timing"
  homepage "https://www.tempodelay.tech/"

  livecheck do
    url :url
    regex(/^tempo[._-]delay[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  # The installer declares arm64 only and a 12.0 minimum, so the cask does too;
  # without the arch line Homebrew would offer it to Intel Macs it cannot run on.
  depends_on macos: ">= :monterey"
  depends_on arch: :arm64

  pkg "StudioZIOTempoDelay-v#{version}-macOS-arm64.pkg"

  # Identifiers read from the installer's own PackageInfo files. The mixed case
  # is deliberate -- pkgutil matches these exactly.
  uninstall pkgutil: [
    "com.StudioZIO.StudioZIOTempoDelay.app.pkg",
    "com.StudioZIO.StudioZIOTempoDelay.component.pkg",
    "com.StudioZIO.StudioZIOTempoDelay.vst3.pkg",
  ]
end
