require 'formula'

HOMEBREW_GHQ_VERSION='0.3'
class Ghq < Formula
  homepage 'https://github.com/motemen/ghq'
  url "https://github.com/motemen/ghq/releases/download/v#{HOMEBREW_GHQ_VERSION}/ghq_darwin_amd64.zip"
  sha1 "f53b4ee33e80d9ba2a74ab1fbad553963c458d8d"

  version HOMEBREW_GHQ_VERSION
  head 'https://github.com/motemen/ghq.git', :branch => 'master'

  depends_on 'unzip' => :build

  def install
    bin.install 'ghq'
  end
end