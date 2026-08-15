class Docrev < Formula
  desc "A terminal document viewer with inline review comments, designed for AI agent workflows"
  homepage "https://github.com/kaneko1117/docrev"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.2.0/docrev-aarch64-apple-darwin.tar.xz"
      sha256 "9fb0825f42302eee2ca431ebf94dbdc1ec6012350a510633c70e7d4c1364abb0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.2.0/docrev-x86_64-apple-darwin.tar.xz"
      sha256 "dcfc0b82b69b6d12d2f1c020646b51b9444a2648e4218c6c0c02b5cd0cbbb722"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.2.0/docrev-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9ef9e019c9bb86dd0255b5d26125564e85417ecb0b33db47dd8851c8fa9d524c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaneko1117/docrev/releases/download/v0.2.0/docrev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b54e1fd5335040a6cc8abdfde1689caf332b275e626101837b2fea4bc953fdf0"
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
