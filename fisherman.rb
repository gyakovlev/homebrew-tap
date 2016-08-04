class Fisherman < Formula
  desc "fish plugin manager"
  homepage "https://github.com/fisherman/fisherman"

  url "https://raw.githubusercontent.com/fisherman/fisherman/2.10.0/fisher.fish"
  sha256 "a5f982ac0ade82c88a8a4da0b014a33266492f95a9156022534b6a1f8d7dd0b3"

  head "https://github.com/fisherman/fisherman.git"

  depends_on "fish"

  def install
    (share/"fish/vendor_functions.d/").install "fisher.fish"
    File.write("fisher-completion.fish", "fisher --complete")
    fish_completion.install "fisher-completion.fish" => "fisher.fish"
    ohai "You may need to restart any open terminal sessions for changes to take effect."
  end
end
