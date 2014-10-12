require 'formula'

HOMEBREW_GHQ_VERSION='0.5'
class Ghq < Formula
  homepage 'https://github.com/motemen/ghq'
  url "https://github.com/motemen/ghq/releases/download/v#{HOMEBREW_GHQ_VERSION}/ghq_darwin_amd64.zip"
  sha1 '504048dcb14bd91bd781e270853d86307c1dfa71'

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
