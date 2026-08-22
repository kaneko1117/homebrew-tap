class Docrev < Formula
  desc "A terminal document viewer with inline review comments, designed for AI agent workflows"
  homepage "https://github.com/kaneko1117/docrev"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.3.0/docrev-aarch64-apple-darwin.tar.xz"
      sha256 "98bb4634c73d244846449001c9ea07d7abfa45972e8cbfa15eeeb509ddaf1ab4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.3.0/docrev-x86_64-apple-darwin.tar.xz"
      sha256 "4e3b1b192d8ef97505b24b1d632c94de9d8a0c5d99f4ff181fa584341cd4cfce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.3.0/docrev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0e944b512d990073a082bd47fe029b358e8a673e5e36b86645b69d4e13586872"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.3.0/docrev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "56f489bcf9de02b3bd6c5fc9cc118dd146ce6521ccf6665122732aeda10eb7ee"
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
