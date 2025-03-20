{
   pkgs,
   config,
   ...
}: {
   home = {
      sessionVariables = {
         QT_STYLE_OVERRIDE = "kvantum";
         GTK_USE_PORTAL = 1;
         WLR_NO_HARDWARE_CURSORS = 1;
     };
   };

   catppuccin = {
     flavor = "mocha";
     accent = "mauve";
     enable = true;
   };

   nixpkgs.config.allowUnfree = true;

   programs.git = {
      enable = true;
      userName = "TheBunnyMan123";
      userEmail = "bunny@tkbunny.net";
      includes = [
         {
            contents = {
               safe = {
                  directory = "*";
               };
            };
         }
      ];
   };

   home.file.".ssh/rc".source = ''
       tmux new -A
   '';

   programs.yazi = {
      enable = true;
      enableZshIntegration = true;
   };

   programs.fastfetch = {
      enable = true;

      settings = {
         modules = [
            "host"
            "os"
            "bootmgr"
            "uptime"
            "terminal"
            "shell"
            "break"
            "gpu"
            "cpu"
            "disk"
            "memory"
            "swap"
         ];
      };
   };

   programs.zoxide = {
      enable = true;
      enableZshIntegration = true;

      options = [
         "--cmd cd"
      ];
   };

   programs.eza = {
      enable = true;
      icons = "auto";
      git = true;

      extraOptions = [
         "--color=always"
      ];
   };

   programs.bat = {
      enable = true;
   };

   programs.btop = {
      enable = true;
   };

   programs.neovim = {
      enable = true;
      defaultEditor = true;

      extraPackages = with pkgs; [
# Language Servers
         kotlin-language-server #Kotlin
         #jdt-language-server # Java
         vscode-langservers-extracted # HTML/CSS/JSON/ESLint
         nixd # Nix
         lua-language-server # Lua
         bash-language-server # Bash
         omnisharp-roslyn # C#
# C/C++
         bear
         ccls
         rust-analyzer # Rust
      ];

      plugins = with pkgs.vimPlugins; [
         {
            plugin = which-key-nvim;
            config = builtins.readFile ./extrafiles/neovim/which-key.lua;
            type = "lua";
         }
         {
            plugin = nvim-treesitter.withAllGrammars;
            config = builtins.readFile ./extrafiles/neovim/treesitter.lua;
            type = "lua";
         }
         {
            plugin = lsp-zero-nvim;
            config = builtins.readFile ./extrafiles/neovim/lsp-zero.lua;
            type = "lua";
         }
         {
            plugin = nvim-lspconfig;
            config = builtins.readFile ./extrafiles/neovim/lspconfig.lua;
            type = "lua";
         }
         {
            plugin = presence-nvim;
            config = builtins.readFile ./extrafiles/neovim/presence.lua;
            type = "lua";
         }
         {
            plugin = nvim-cmp;
            config = builtins.readFile ./extrafiles/neovim/cmp.lua;
            type = "lua";
         }
         {
            plugin = nvim-tree-lua;
            config = ''
               require("nvim-tree").setup {}
            '';
            type = "lua";
         }
         {
            plugin = undotree;
            type = "lua";
         }
         {
           plugin = catppuccin-nvim;
           config = ''
             '';
           type = "lua";
         }

         markdown-preview-nvim
         cmp-snippy
         cmp-nvim-lsp
         cmp-buffer
         cmp-path
         cmp-cmdline
         nvim-snippy
         vim-snippets
         luasnip
         telescope-nvim
         vim-tmux-navigator
      ];

      extraLuaConfig = ''
         ${"\n"}
         vim.opt.guicursor = ""

         vim.opt.nu = true

         vim.opt.tabstop = 3
         vim.opt.softtabstop = 3
         vim.opt.shiftwidth = 3
         vim.opt.expandtab = true

         vim.opt.smartindent = true

         vim.opt.wrap = false

         vim.opt.hlsearch = false
         vim.opt.incsearch = true

         vim.opt.scrolloff = 8
         vim.opt.signcolumn = "yes"
      '';
   };

   programs.tmux = {
      enable = true;
      keyMode = "vi";
      mouse = true;
      prefix = "C-Space";
      secureSocket = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "xterm-kitty";
      extraConfig = ''set -sg terminal-overrides ",*:RGB"'';

      plugins = with pkgs.tmuxPlugins; [
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

   };

   programs.zsh = {
      enable = true;
      enableCompletion = true;
      
      shellAliases = {
         sudo = "sudo -p \"$(echo \"\\033[38;5;240m[\\033[38;5;1mSUDO\\033[38;5;240m] \\033[38;5;14mPassword\\033[0m: \")\"";
         l = "ls -al";
         ll = "ls -l";
         ls = "eza --color=auto";
         grep = "grep --color=auto";
         rm = "mvtotrash";
         espeak="espeak -a 200 -g 0 -k 16 -p 46";
         espeak-ng="espeak-ng -a 200 -g 0 -k 16 -p 46";
         yt-dlp="yt-dlp --download-archive ./yt-dlp-archive -o \"%(playlist_index)s - %(title)s [%(id)s].%(ext)s\" --merge-output-format mkv --write-description --embed-chapters --sub-lang en --embed-subs --embed-metadata --embed-info-json";
      };

      autosuggestion = {
         enable = true;
         highlight = "fg=cyan,bg=black,underline";
      };
      history = {
         extended = true;
         ignoreDups = true;
         ignoreSpace = true;
         append = true;
         path = "$HOME/.zsh_history";
         save = 10000;
         share = true;
         size = 10000;
      };

      initExtraFirst = ''
         if (( $+commands[Hyprland] ))
         then
            if [[ "$(tty)" != "/dev/tty1" ]]
            then
               test -z "$TMUX" && (tmux attach &> /dev/null || tmux new-session)
            fi
         else
            test -z "$TMUX" && (tmux attach &> /dev/null || tmux new-session)
         fi
      '';
      initExtra = ''
         autoload -Uz vcs_info
         precmd() { vcs_info }

         EDITOR="${config.programs.neovim.finalPackage}/bin/nvim"
         VISUAL="${config.programs.neovim.finalPackage}/bin/nvim"
         PAGER="${pkgs.w3m}/bin/w3m"

         ${builtins.readFile(./extrafiles/zsh/envvars.sh)}
         ${builtins.readFile(./extrafiles/zsh/funcs.sh)}
         ${builtins.readFile(./extrafiles/zsh/prompt.sh)}

         if (( $+commands[fok-quote] ))
         then
            fok-quote
         fi
      '';

      syntaxHighlighting = {
         enable = true;
      };
   };
}

