require 'formula'

HOMEBREW_GHQ_VERSION='0.7'
class Ghq < Formula
  homepage 'https://github.com/motemen/ghq'
  if OS.mac?
    url "https://github.com/motemen/ghq/releases/download/v#{HOMEBREW_GHQ_VERSION}/ghq_darwin_amd64.zip"
    sha256 '96c6b8dc16fda605cad0b2000c1856cfc9df5bfe1987ba38e86cd773f39fb3e7'
  elsif OS.linux?
    url "https://github.com/motemen/ghq/releases/download/v#{HOMEBREW_GHQ_VERSION}/ghq_linux_amd64.zip"
    sha256 'd0d285d190ab5adb06c120a005305b41e8e47ef068de85f8e4de2fac4cd8cf17'
  end

  version HOMEBREW_GHQ_VERSION
  head 'https://github.com/motemen/ghq', :using => :git, :branch => 'master'

  option 'without-completions', 'Disable zsh completions'

  if build.head?
    depends_on 'go' => :build
    depends_on 'hg' => :build
  end

  def install
    if build.head?
      gopath = buildpath/'.go'

      ( gopath/'src/github.com/motemen/ghq' ).make_relative_symlink buildpath

      ENV['GOPATH'] = gopath
      system 'make', 'BUILD_FLAGS=-o ghq'

    end

    if build.with? 'completions'
      zsh_completion.install 'zsh/_ghq'
    end

    bin.install 'ghq'
  end
end
