class Docrev < Formula
  desc "A terminal document viewer with inline review comments, designed for AI agent workflows"
  homepage "https://github.com/kaneko1117/docrev"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.4.0/docrev-aarch64-apple-darwin.tar.xz"
      sha256 "5b19c5ee3ecd4783cf783c9ae1e24ed066031046e5e22f4f4f8bf8bba5fb94be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.4.0/docrev-x86_64-apple-darwin.tar.xz"
      sha256 "dd9148c7c87e21019aa943c46799e3f2108e849820152850a60bce988c9918b7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.4.0/docrev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5a3f6b4c2fe461d488a5a893e0c8428601a00ed4a69524955d20a2f9f7d09690"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.4.0/docrev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a45a22436699849278d70d1f3e66045b636c177b6e4ac4abf2e284fee6d1bf74"
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
