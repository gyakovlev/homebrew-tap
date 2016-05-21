class Fisherman < Formula
  desc "Fish plugin manager"
  homepage "https://github.com/fisherman/fisherman"

  url "https://raw.githubusercontent.com/fisherman/fisherman/2.7.8/fisher.fish"
  sha256 "72ad19b140183175540c5eae34cea6c362accb62e3057e86e26b47494661f7b3"

  head "https://github.com/fisherman/fisherman.git"

  depends_on "fish"


  require 'open3'

  def fish_v
    out, st = Open3.capture2e("fish -v")
    if st.exitstatus != 0
      odie "Fish is not found!"
    else
      out.strip
    end
  end

  def fish_2_2?
    fish_v.start_with?("fish, version 2.2")
  end


  def install
    share.install "fisher.fish"

    fish_prefix = File.realpath("#{HOMEBREW_PREFIX}/opt/fish/")

    destination =
      if fish_2_2?
        "#{fish_prefix}/share/fish/functions"
      else
        "#{fish_prefix}/share/fish/vendor_functions.d"
      end

    ohai "fisher function will live in \n #{destination}"

    makedirs destination
    ln_sf "#{share}/fisher.fish", "#{destination}/fisher.fish"
  end


  def caveats
    if fish_2_2?
      <<-EOS.undent
        It seems that you are running fish 2.2. For snippet support, upgrade to >=2.3 or
        append the following code to your ~/.config/fish/config.fish:

            for file in ~/.config/fish/conf.d/*.fish
                source $file
            end
      EOS
    end
  end


  test do
    system "fish", "-c", "fisher -v"
    # tried to check here, that the output version is the same as in the formula
    # but it doesn't make sense with HEAD
  end
end
