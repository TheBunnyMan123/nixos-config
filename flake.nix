{
  description = "Flake for NixOS";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hardware.url = "github:nixos/nixos-hardware";
    systems.url = "github:nix-systems/default-linux";
    fok-quote.url = "github:fokohetman/fok-quote";
  };

  outputs = { self, catppuccin, nixpkgs, home-manager, systems, hardware, fok-quote, ... } @inputs:
  let
    inherit (self) outputs;

    lib = nixpkgs.lib // home-manager.lib;
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in rec {
    createUser = import ./createUser.nix;

    nixosModules = {
      bunny-sshworthy = createUser {
        name = "bunny";
        hashedPassword = "$y$j9T$yk.0wI1bKFcSByKp3QYZI/$xFSdjqnJygu4ut6NyY5bfIsBDPSoSrIoNATs9vVD29B";
        shell = pkgs: pkgs.zsh;
        systemUser = false;
        uid = 26897;
        description = "TheKillerBunny / TheBunnyMan123";
        linger = true;
        home = "/home/bunny";
      
        packages = pkgs: with pkgs; [
          zsh
          coreutils-full
          (callPackage ../../packages/icat.nix { })
          git
          ffmpeg
          fastfetch
          github-cli
          tmux
          zoxide
          fzf
          stow
          eza
          bat
          w3m
          zoxide
          jdk21
          espeak-ng
          vscodium
          prismlauncher
          gcc
          fok-quote.packages."${system}".default
        ];

        extraHomeConfig = {
          catppuccin = {
            flavor = "macchiato";
            accent = "blue";
            enable = true;
            pointerCursor = {
              flavor = "macchiato";
              accent = "blue";
              enable = true;
            };
          };

          gtk.catppuccin = {
            flavor = "macchiato";
            accent = "blue";
            enable = true;
            icon = {
              flavor = "macchiato";
              accent = "blue";
              enable = true;
            };
          };

          qt.style.catppuccin = {
            flavor = "macchiato";
            accent = "blue";
            enable = true;
          };

          programs.alacritty = {
            enable = true;
            catppuccin = {
              flavor = "macchiato";
              enable = true;
            };
          };

          programs.bat = {
            enable = true;
            catppuccin = {
              flavor = "macchiato";
              enable = true;
            };
          };

          programs.btop = {
            enable = true;
            catppuccin = {
              flavor = "macchiato";
              enable = true;
            };
          };

          programs.neovim = {
            enable = true;
            defaultEditor = true;

            plugins = pkgs: with pkgs.vimPlugins; [
              {
                plugin = which-key-nvim;
                config = ''
                  vim.o.timeout = true
                  vim.o.timeoutlen = 500
            
                  vim.g.mapleader = " "
            
                  local wk = require("which-key")
                  wk.register({
                    ["<leader>tr"] = { ":Ex<CR>", "File Tree" },
                  }, { mode = "n" })

                  wk.register({
                    ["<leader>ff"] = { ":Telescope find_files<CR>", "Find Files" },
                  }, { mode = "n" })
                  wk.register({
                    ["<leader>gf"] = { ":Telescope git_files<CR>", "Git Files" },
                  }, { mode = "n" })
                '';
                type = "lua";
              }
              {
                plugin = nvim-treesitter;
                config = ''
                  local configs = require("nvim-treesitter.configs")

                  configs.setup({
                    ensure_installed = { "c", "lua", "json", "vim", "vimdoc", "query", "java", "c_sharp", "nix" },
                    sync_install = true,
                    highlight = { enable = true },
                    indent = { enable = false },
                    auto_install = true,
                    parser_install_dir = "/home/bunny/.cache/nvim-treesitter/parsers",
                  })
                '';
                type = "lua";
              }

              luasnip
              telescope-nvim
            ];

            extraLuaConfig = ''
              ${"\n"}
              vim.opt.guicursor = ""
    
              vim.opt.nu = true
    
              vim.opt.tabstop = 2
              vim.opt.softtabstop = 2
              vim.opt.shiftwidth = 2
              vim.opt.expandtab = true
    
              vim.opt.smartindent = true
   
              vim.opt.wrap = false
   
              vim.opt.hlsearch = false
              vim.opt.incsearch = true
   
              vim.opt.scrolloff = 8
              vim.opt.signcolumn = "yes"
            '';
 
            catppuccin = {
              flavor = "macchiato";
              enable = true;
            };
          };

          programs.tmux = {
            enable = true;
            keyMode = "vi";
            mouse = true;
            prefix = "C-Space";
            secureSocket = true;
            shell = pkgs: "${pkgs.zsh}/bin/zsh";
            terminal = "screen-256color";
            extraConfig = ''set -sg terminal-overrides ",*:RGB"'';

            plugins = pkgs: with pkgs.tmuxPlugins; [
              sensible
              vim-tmux-navigator

              {
                plugin = yank;
                extraConfig = ''
                  bind-key -T copy-mode-vi v send-keys -X begin-selection
                  bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
                  bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
                '';
              }
            ];

            catppuccin = {
              flavor = "macchiato";
              enable = true;
            };
          };

          programs.zsh = {
            enable = true;
            enableCompletion = true;

            autosuggestion = {
              enable = true;
              highlight = "fg=cyan,bg=black,underline";
            };
            history = {
              extended = true;
              ignoreDups = true;
              ignoreSpace = true;
              path = "$HOME/.zsh_history";
              save = 10000;
              share = true;
              size = 10000;
            };

            initExtraFirst = ''
              if (( $+commands[tmux] ))
              then
                test -z "$TMUX" && (tmux attach &> /dev/null || tmux new-session)
              fi
            '';
            initExtra = ''
              autoload -Uz vcs_info
              precmd() { vcs_info }

              ${builtins.readFile(../../extrafiles/zsh/aliases.sh)}
              ${builtins.readFile(../../extrafiles/zsh/envvars.sh)}
              ${builtins.readFile(../../extrafiles/zsh/funcs.sh)}
              ${builtins.readFile(../../extrafiles/zsh/prompt.sh)}

              if (( $+commands[fok-quote] ))
              then
                fok-quote
              fi
            '';

            syntaxHighlighting = {
              enable = true;
              catppuccin = {
                flavor = "macchiato";
                enable = true;
              };
            };
          };
        };
      };
    };

    nixosConfigurations = {  
      Desktop = lib.nixosSystem {
        system = "x86_64-linux"; 
        modules = [
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {home-manager.users.bunny.imports = [catppuccin.homeManagerModules.catppuccin];}
          ./hosts/desktop
        ];

        specialArgs = let homeStateVersion = "23.05"; in {
          inherit inputs outputs createUser homeStateVersion fok-quote;
        };
      };
    };
  };
}
