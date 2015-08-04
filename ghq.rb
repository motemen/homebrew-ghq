require 'formula'

HOMEBREW_GHQ_VERSION='0.7'
class Ghq < Formula
  homepage 'https://github.com/motemen/ghq'
  if OS.mac?
    url "https://github.com/motemen/ghq/releases/download/v#{HOMEBREW_GHQ_VERSION}/ghq_darwin_amd64.zip"
    sha1 'a860532b6529be74604334e5086c139831fc2be9'
  elsif OS.linux?
    url "https://github.com/motemen/ghq/releases/download/v#{HOMEBREW_GHQ_VERSION}/ghq_linux_amd64.zip"
    sha1 "d939d68338659dc0721056c62a5b8f709554b5ce"
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
