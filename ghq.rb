require 'formula'

HOMEBREW_GHQ_VERSION='0.3'
class Ghq < Formula
  homepage 'https://github.com/motemen/ghq'
  url "https://github.com/motemen/ghq/releases/download/v#{HOMEBREW_GHQ_VERSION}/ghq_darwin_amd64.zip"

  version HOMEBREW_GHQ_VERSION
  head 'https://github.com/motemen/ghq.git', :branch => 'master'

  depends_on 'unzip' => :build

  def install
    bin.install 'ghq'
  end
end