require 'formula'

HOMEBREW_GHQ_VERSION='0.6'
class Ghq < Formula
  homepage 'https://github.com/motemen/ghq'
  if OS.mac?
    url "https://github.com/motemen/ghq/releases/download/v#{HOMEBREW_GHQ_VERSION}/ghq_darwin_amd64.zip"
    sha1 'eff77abc345fa2c5581875f4e3c8fc4e2b9bf0ac'
  elsif OS.linux?
    url "https://github.com/motemen/ghq/releases/download/v#{HOMEBREW_GHQ_VERSION}/ghq_linux_amd64.tar.gz"
    sha1 "b6c45ff1a57b1fac12b2f49ae12b9dbf2c71a936"
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
