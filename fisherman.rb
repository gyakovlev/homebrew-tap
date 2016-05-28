class Fisherman < Formula
    desc "fish plugin manager"
    homepage "https://github.com/fisherman/fisherman"

    url "https://raw.githubusercontent.com/fisherman/fisherman/2.9.0/fisher.fish"
    sha256 "a646cad301ffa186032f09e8d2a06ee29dea567d1a4fab61b5f07828fd902f11"

    head "https://github.com/fisherman/fisherman.git"

    depends_on "fish"

    require 'open3'

    def fish_v
        out, st = Open3.capture2e("fish -v")
        if st.exitstatus != 0
            odie "fish-shell not installed."
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

        functions_dest =
            if fish_2_2?
                "#{fish_prefix}/share/fish/functions"
            else
                "#{fish_prefix}/share/fish/vendor_functions.d"
            end

        completions_dest =
            if fish_2_2?
                "#{fish_prefix}/share/fish/completions"
            else
                "#{fish_prefix}/share/fish/vendor_completions.d"
            end

        ohai "fisherman will be linked to:"
        ohai "#{functions_dest}"
        ohai "#{completions_dest}\n"

        ohai "You may need to restart any open terminal sessions for changes to take effect."

        makedirs functions_dest
        makedirs completions_dest

        File.write("#{share}/fisher-complete.fish", "fisher --complete")

        ln_sf "#{share}/fisher.fish", "#{functions_dest}/fisher.fish"
        ln_sf "#{share}/fisher-complete.fish", "#{completions_dest}/fisher.fish"
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
end
