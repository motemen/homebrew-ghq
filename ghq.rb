require 'formula'

HOMEBREW_GHQ_VERSION='0.4'
class Ghq < Formula
  homepage 'https://github.com/motemen/ghq'
  url "https://github.com/motemen/ghq/releases/download/v#{HOMEBREW_GHQ_VERSION}/ghq_darwin_amd64.zip"
  sha1 '220d77560e6619d4d53c42c9c5c68d3c9fb03f5b'

  version HOMEBREW_GHQ_VERSION
  head 'https://github.com/motemen/ghq', :using => :git, :branch => 'master'

  if build.head?
    depends_on 'go' => :build
    depends_on 'hg' => :build
  else
    depends_on 'unzip' => :build
  end

  def install
    if build.head?
      gopath = buildpath/'.go'

      ( gopath/'src/github.com/motemen/ghq' ).make_relative_symlink buildpath

      ENV['GOPATH'] = gopath
      system 'make', 'BUILD_FLAGS=-o ghq'
    end

    bin.install 'ghq'
  end
end
