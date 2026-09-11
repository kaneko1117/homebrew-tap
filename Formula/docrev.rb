class Docrev < Formula
  desc "A terminal document viewer with inline review comments, designed for AI agent workflows"
  homepage "https://github.com/kaneko1117/docrev"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.5.0/docrev-aarch64-apple-darwin.tar.xz"
      sha256 "7400301783d008a1e7311fc7566d13d3ec73349f338fbb6d71b26bd50ef53a77"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.5.0/docrev-x86_64-apple-darwin.tar.xz"
      sha256 "afb7e2dc9ade5b1d8e6bdc74e9f429c3e300b39fea05a93c2b3c22e777791689"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.5.0/docrev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fa2b6805c46f183b2c1abc745790e82e4e79ae4fc2cf358c1eda286a555b0861"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.5.0/docrev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dbe7e15e23e1eb548ef2510f072fc054ec81ad7b24b0d346c5def0dac5b795d6"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "docrev"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "docrev"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "docrev"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "docrev"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
