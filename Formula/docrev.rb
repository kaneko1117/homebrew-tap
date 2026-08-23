class Docrev < Formula
  desc "A terminal document viewer with inline review comments, designed for AI agent workflows"
  homepage "https://github.com/kaneko1117/docrev"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.3.1/docrev-aarch64-apple-darwin.tar.xz"
      sha256 "31af8d041ed2e9f997d65b9fcdc37bae2c60b8569f7d1dce7d3b5109f6ed5dbe"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.3.1/docrev-x86_64-apple-darwin.tar.xz"
      sha256 "4d4fdd29fad87b2e2d222697cdd5447fe59adee11f6c9286364fbb530c67057a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.3.1/docrev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b261f21a613d65cc6f6fa190aadc717813b29d07cb9e76f65b6937627e4dcb1e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.3.1/docrev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "42f838ed8dd6d686aa21a75fa3403bb2c856e9400288e93ba1fcac91af2b25d2"
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
