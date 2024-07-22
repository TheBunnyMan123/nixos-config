{
  pkgs,
  inputs,
  createUser,
  fok-quote,
  homeStateVersion,
  ...
}: {
  users.mutableUsers = false;

  imports = [
    (
      createUser {
        name = "root";
        hashedPassword = "$y$j9T$r7Q60T/F48oyLnK8OnVXT.$cbSoNXPw3WbC9nW.nvQ5VpXYmwC3HmIuQoykavM4lGD";
        shell = pkgs.bash;
        systemUser = true;
        uid = 0;
        home = "/root";
        description = "System administrator";
        packages = with pkgs; [
          neovim
          coreutils-full
        ];
        extraHomeConfig = {
          home.stateVersion = homeStateVersion;
        };
      }
    ) (
      createUser {
        name = "bunny";
        hashedPassword = "$y$j9T$yk.0wI1bKFcSByKp3QYZI/$xFSdjqnJygu4ut6NyY5bfIsBDPSoSrIoNATs9vVD29B";
        shell = pkgs.zsh;
        canSudo = true;
        groups = ["networkmanager" "libvirtd" "docker" "adbusers"];
        systemUser = false;
        uid = 1000;
        description = "TheKillerBunny / TheBunnyMan123";
        linger = true;
        home = "/home/bunny";
      
        packages = with pkgs; [
          coreutils-full
          (callPackage ../../packages/icat.nix { })
          (callPackage ../../packages/remote.nix { })
          sshfs
          ffmpeg
          github-cli
          fzf
          stow
          w3m
          jdk21
          espeak-ng
          prismlauncher
          gcc
          fok-quote.packages.${pkgs.system}.default
        ];

        extraHomeConfig = {
          home.stateVersion = homeStateVersion;
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
                binaryPrefix = "si";
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

          programs.vscode = {
            enable = true;
            enableUpdateCheck = false;
            package = pkgs.vscodium;

            extensions = with pkgs.vscode-extensions; [
              mhutchie.git-graph
              jnoortheen.nix-ide
              aaron-bond.better-comments
              catppuccin.catppuccin-vsc-icons
              catppuccin.catppuccin-vsc
            ];

            userSettings = {
              "workbench.colorTheme" = "Catppuccin Macchiato";
              "workbench.iconTheme" = "catppuccin-macchiato";
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
            icons = true;
            git = true;

            extraOptions = [
              "--color=always"
            ];
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

            extraPackages = with pkgs; [
              # Language Servers
              omnisharp-roslyn # C#
              java-language-server # Java
              vscode-langservers-extracted # HTML/CSS/JSON/ESLint
              nixd # Nix
              lua-language-server # Lua
            ];

            plugins = with pkgs.vimPlugins; [
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
                  
                  lspconfig.java_language_server.setup{}
                  lspconfig.nixd.setup{}

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
                  lspconfig.omnisharp.setup {
                    cmd = { "dotnet", "/path/to/omnisharp/OmniSharp.dll" },
                
                    settings = {
                      FormattingOptions = {
                        EnableEditorConfigSupport = true,
                        OrganizeImports = nil,
                      },
                      MsBuild = {
                        LoadProjectsOnDemand = nil,
                      },
                      RoslynExtensionsOptions = {
                        EnableAnalyzersSupport = nil,
                        EnableImportCompletion = nil,
                        AnalyzeOpenDocumentsOnly = nil,
                      },
                      Sdk = {
                        IncludePrereleases = true,
                      },
                    },
                  }
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

              cmp-snippy
              cmp-nvim-lsp
              cmp-buffer
              cmp-path
              cmp-cmdline
              nvim-snippy
              vim-snippets
              omnisharp-extended-lsp-nvim
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
            shell = "${pkgs.zsh}/bin/zsh";
            terminal = "screen-256color";
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
      }
    )
  ];

  environment.pathsToLink = [ "/share/zsh" ];
}
