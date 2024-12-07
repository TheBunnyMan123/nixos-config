{
   pkgs,
   config,
   ...
}: rec {
   home = {
      sessionVariables = {
         QT_STYLE_OVERRIDE = "kvantum";
         GTK_USE_PORTAL = 1;
         WLR_NO_HARDWARE_CURSORS = 1;
     };
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

   programs.yazi = {
      enable = true;
      enableZshIntegration = true;
   };

   programs.fastfetch = {
      enable = true;

      settings = {
         logo = {
            source = "nixos_small";
            padding = {
               right = 1;
            };
         };

         display = {
            size.binaryPrefix = "si";
            color = "blue";
            separator = "  ";
         };

         modules = [
            "host"
            "os"
            "uptime"
            "break"
            "gpu"
            "cpu"
            "memory"
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
         jdt-language-server # Java
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
            config = ''
               vim.o.timeout = true
               vim.o.timeoutlen = 500

               vim.g.mapleader = " "

               local wk = require("which-key")
               wk.add(
                  { "<leader>tr", ":NvimTreeFocus<CR>", desc = "File Tree" }
               )
               wk.add(
                  { "<leader>ctr", ":NvimTreeClose<CR>", desc = "Close File Tree" }
               )

               wk.add(
                  { "<leader>ff", ":Telescope find_files<CR>", desc = "Find Files" }
               )
               wk.add(
                  { "<leader>gf", ":Telescope git_files<CR>", desc = "Git Files" }
               )
               wk.add(
                 { "<leader>bf", ":buffers<CR>", desc = "Buffers" }
               )
               wk.add(
                  { "<leader>ut", ":UndotreeToggle<CR>", desc = "Toggle Undo Tree" }
               )
               '';
            type = "lua";
         }
         {
            plugin = nvim-treesitter.withAllGrammars;
            config = ''
               local configs = require("nvim-treesitter.configs")

               configs.setup({
                  highlight = { enable = true },
                  indent = { enable = false },
               })
            '';
            type = "lua";
         }
         {
            plugin = lsp-zero-nvim;
            config = ''
               local lsp_zero = require('lsp-zero')

               lsp_zero.on_attach(function(client, bufnr)
                  -- see :help lsp-zero-keybindings
                  -- to learn the available actions
                  lsp_zero.default_keymaps({buffer = bufnr})
               end)
               '';
            type = "lua";
         }
         {
            plugin = nvim-lspconfig;
            config = ''
               local lspconfig = require('lspconfig')
               local capabilities = vim.lsp.protocol.make_client_capabilities()

               capabilities.textDocument.completion.completionItem.snippetSupport = true

               lspconfig.ccls.setup{}
               lspconfig.nixd.setup{}
               lspconfig.bashls.setup{}
               lspconfig.kotlin_language_server.setup{}
               lspconfig.html.setup {
                  capabilities = capabilities,
               }
               lspconfig.jsonls.setup {
                  capabilities = capabilities,
               }
               lspconfig.cssls.setup {
                  capabilities = capabilities,
               }
               lspconfig.eslint.setup({
                  on_attach = function(client, bufnr)
                  vim.api.nvim_create_autocmd("BufWritePre", {
                     buffer = bufnr,
                     command = "EslintFixAll",
                  })
               end,
            })
            lspconfig.lua_ls.setup {
               on_init = function(client)
                  local path = client.workspace_folders[1].name
                  if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                     return
                  end

                  client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                     workspace = {
                        checkThirdParty = false,
                        library = {
                           vim.env.VIMRUNTIME
                        }
                     }
                 })
               end,
               settings = {
                  Lua = {}
               }
            }
            lspconfig.rust_analyzer.setup{
               settings = {
                  ['rust-analyzer'] = {
                     diagnostics = {
                        enable = false;
                     }
                  }
               }
            }
            '';
            type = "lua";
         }
         {
            plugin = nvim-jdtls;
            config = ''
               require('jdtls').start_or_attach({
                  cmd = {'${pkgs.jdt-language-server}/bin/jdtls'},
                  root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
               })
            '';
            type = "lua";
         }
         {
            plugin = nvim-cmp;
            config = ''
               local cmp = require('cmp')
               local cmp_action = require('lsp-zero').cmp_action()

               cmp.setup({
                  mapping = cmp.mapping.preset.insert({
                     -- `Enter` key to confirm completion
                     ['<CR>'] = cmp.mapping.confirm({select = false}),

                     -- Ctrl+Space to trigger completion menu
                     ['<C-Space'] = cmp.mapping.complete(),

                     -- Navigate between snippet placeholder
                     ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                     ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                     -- Scroll up and down in the completion documentation
                     ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                     ['<C-d>'] = cmp.mapping.scroll_docs(4),
                  }),
                  snippet = {
                  expand = function(args)
                  require('luasnip').lsp_expand(args.body)
               end,
               },
               sources = cmp.config.sources({
                  { name = 'nvim_lsp' },
                  { name = 'snippy' },
                  }, {
                     { name = 'buffer' },
                 })
              })
            '';
            type = "lua";
         }
         {
            plugin = nvim-tree-lua;
            config = ''
               require("nvim-tree").setup{}
            '';
            type = "lua";
         }
         {
            plugin = undotree;
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

               source ${./extrafiles/tmux.conf}
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

