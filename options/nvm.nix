{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.zsh.nvm;
  pkg = (import ../pkgs/nvm/default.nix);
in
  {
    options = {
      programs.zsh.nvm = {
        enable = mkOption {
          default = false;
          description = ''
            Enable nvm.
          '';
        };

        enableForRoot = mkOption {
          default = false;
          description = ''
            Enable nvm for root.
          '';
        };

        autoUse = mkOption {
          default = false;
          description = ''
            Automatically call `nvm use` when entering a directory with a .nvmrc file.
          '';
        };

        buildFromSource = mkOption {
          default = true;
          description = ''
            Build from source when installing instead of using prebuilt binaries.
          '';
        };

        enableCompletion = mkOption {
          default = true;
          description = ''
            Enable argument completion.
          '';
        };

        additionalLDLibraries = mkOption {
          default = "";
          description = ''
            Additional LD libraries to be included as part of LD_LIBRARY_PATH
          '';
        };

        additionalLDFlags = mkOption {
          default = "";
          description = ''
            Additional LD flags to be included as part of LDFLAGS
          '';
        };

        additionalCPPFlags = mkOption {
          default = "";
          description = ''
            Additional CPP flags to be included as part of CPPFLAGS
          '';
        };

        additionalPath = mkOption {
          default = "";
          description = ''
            Additional paths to be included as part of PATH
          '';
        };

        force32Bit = mkOption {
          default = false;
          description = ''
            Use 32-bit Node.js on a 64-bit system.
          '';
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        pkg
        python
        gnumake
        gcc
      ];

      programs.zsh.interactiveShellInit = with builtins; ''
        ${optionalString (!cfg.enableForRoot)
          ''if [[ $USER != 'root' ]]; then''
        };

        NNW_LD_LIBRARY_PATH=(
          ${pkgs.glibc}/lib
          ${pkgs.gcc-unwrapped}/lib
          ${pkgs.gcc-unwrapped.lib}/lib

          ${pkgs.gtk2-x11}/lib
          ${pkgs.atk}/lib
          ${pkgs.glib}/lib
          ${pkgs.pango.out}/lib
          ${pkgs.gdk_pixbuf}/lib
          ${pkgs.cairo}/lib
          ${pkgs.freetype}/lib
          ${pkgs.fontconfig.lib}/lib
          ${pkgs.dbus.lib}/lib
          ${pkgs.xorg.libXi}/lib
          ${pkgs.xorg.libX11}/lib
          ${pkgs.xorg.libXcursor}/lib
          ${pkgs.xorg.libXdamage}/lib
          ${pkgs.xorg.libXrandr}/lib
          ${pkgs.xorg.libXcomposite}/lib
          ${pkgs.xorg.libXext}/lib
          ${pkgs.xorg.libXfixes}/lib
          ${pkgs.xorg.libXrender}/lib
          ${pkgs.xorg.libXtst}/lib
          ${pkgs.xorg.libXScrnSaver}/lib
          ${pkgs.xorg.libxcb}/lib
          ${pkgs.gnome2.GConf}/lib
          ${pkgs.nss}/lib
          ${pkgs.nspr}/lib
          ${pkgs.alsaLib}/lib
          ${pkgs.cups.lib}/lib
          ${pkgs.expat}/lib
          ${pkgs.zlib}/lib

          ${cfg.additionalLDLibraries}
        )

        NNW_LDFLAGS=(
          -L${pkgs.glibc}/lib

          ${cfg.additionalLDFlags}
        )

        NNW_CPPFLAGS=(
          -I${pkgs.glibc.dev}/include

          ${cfg.additionalCPPFlags}
        )

        NNW_PATH=(
          ${pkgs.gnumake}/bin
          ${pkgs.python}/bin
          ${cfg.additionalPath}
        )

        LDFLAGS="$LDFLAGS ''${(j: :)NNW_LDFLAGS}" \
        CPPFLAGS="$CPPFLAGS ''${(j: :)NNW_CPPFLAGS}" \
        LD_LIBRARY_PATH=''${(j/:/)NNW_LD_LIBRARY_PATH} \
          source ${pkg}/share/nvm/nvm.sh

        # this is quite gross
        function _nnw-wrap {
          local name="$1" code="$2"

          eval "
            ''${code:+function __nnw_orig-$(functions $name)}

            function $name {
              $code
              nnw_set_prefix=1 _nnw-exec \
                ''${''${code:+__nnw_orig-$name}:-command $name} \$@
            }
          "
        }

        function _nnw-exec {
          local LLP=(
            $NNW_LD_LIBRARY_PATH
            $LD_LIBRARY_PATH
          )

          local NNWP=(
            $NNW_PATH
            $PATH
          )

          if [[ $nnw_set_prefix -eq 1 ]]; then
            local nnw_set_prefix=0

            if [[ ! -v npm_config_prefix ]]; then
              local version=$(_nnw-exec command node --version)
              local npm_config_prefix=$(nvm_version_path $version)
            fi

            npm_config_prefix=$npm_config_prefix _nnw-exec $@
          else
            local env
            local nnw_set_path=''${nnw_set_path:-1}

            if [[ $1 == 'command' ]]; then
              shift
              env=env
            fi

            if [[ $nnw_set_path -eq 0 ]]; then
              LDFLAGS="$LDFLAGS ''${(j: :)NNW_LDFLAGS}" \
              CPPFLAGS="$CPPFLAGS ''${(j: :)NNW_CPPFLAGS}" \
              LD_LIBRARY_PATH=''${(j/:/)LLP} \
                $env $@
            else
              PATH=''${(j/:/)NNWP} \
              LDFLAGS="$LDFLAGS ''${(j: :)NNW_LDFLAGS}" \
              CPPFLAGS="$CPPFLAGS ''${(j: :)NNW_CPPFLAGS}" \
              LD_LIBRARY_PATH=''${(j/:/)LLP} \
                $env $@
            fi
          fi
        }

        if functions nvm >/dev/null; then
          _nnw-wrap nvm $'
            local nnw_set_path=0
            local npm_config_prefix
            if [[ $1 == "use" ]]; then
              npm_config_prefix=$(nvm_version_path $(nvm_match_version $2))
            fi
          '
        fi

        function _nnw-auto-wrap {
          local command=''${1%% *}

          if which -p $command >/dev/null; then
            if [[ $(which -p $command) =~ ^$NVM_DIR/.*\/bin\/[a-z0-9_-]+$ ]]; then
              _nnw-wrap $command
            fi
          fi
        }

        autoload -Uz add-zsh-hook
        add-zsh-hook preexec _nnw-auto-wrap

        ${optionalString (cfg.enableCompletion) "source ${pkg}/share/nvm/bash_completion"}

        ${optionalString (cfg.buildFromSource) ''
          export NVM_SOURCE_INSTALL=1
          export npm_config_build_from_source=true
        ''}

        ${optionalString (!cfg.buildFromSource) ''
          export NVM_SOURCE_INSTALL=0
          export npm_config_build_from_source=false
        ''}

        ${optionalString (cfg.force32Bit) ''
          nvm_get_arch() { nvm_echo "x86" }
          export npm_config_arch=ia32
          export npm_config_target_arch=ia32
        ''}

        ${optionalString (cfg.autoUse) ''
          export NVM_AUTO_USE=true

          autoload -U add-zsh-hook

          load-nvmrc() {
            local node_version="$(nvm version)"
            local nvmrc_path="$(nvm_find_nvmrc)"

            if [[ -n "$nvmrc_path" ]]; then
              local nvmrc_node_version=$(nvm version "$(cat "$nvmrc_path")")

              if [[ "$nvmrc_node_version" = "N/A" ]]; then
                nvm install
              elif [[ "$nvmrc_node_version" != "$node_version" ]]; then
                nvm use
              fi
            elif [[ "$node_version" != "$(nvm version default)" ]]; then
              echo "Reverting to nvm default version"
              nvm use default
            fi
          }

          add-zsh-hook chpwd load-nvmrc
          load-nvmrc
        ''}

        ${optionalString (!cfg.enableForRoot)
          ''fi''
        };
      '';
    };
  }
