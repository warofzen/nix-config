{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  programs = {
    nixvim = {
      enable = true;
      enableMan = true;
      # colorschemes.base16.enable = true;
      opts = {
        hlsearch = true;
        mouse = "a";
        breakindent = true;
        undofile = true;
        timeoutlen = 300;
        completeopt = "menu,menuone,noselect";
        conceallevel = 2; # Hide * markup for bold and italic, but not markers with substitutions
        confirm = true; # Confirm to save changes before exiting modified buffer
        cursorline = true; # Enable highlighting of the current line
        expandtab = true; # Use spaces instead of tabs
        formatoptions = "jcroqlnt"; # tcqj
        grepformat = "%f:%l:%c:%m";
        grepprg = "rg --vimgrep";
        ignorecase = true;
        inccommand = "nosplit"; # preview incremental substitute
        laststatus = 3; # global statusline
        list = true; # Show some invisible characters (tabs...
        number = true; # Print line number
        pumblend = 10; # Popup blend
        pumheight = 10; # Maximum number of entries in a popup
        relativenumber = true; # Relative line numbers
        scrolloff = 4; # Lines of context
        sessionoptions = ["buffers" "curdir" "tabpages" "winsize" "help" "globals" "skiprtp" "folds"];
        shiftround = true; # Round indent
        shiftwidth = 2; # indent size
        showmode = false; # Dont show mode since we have a statusline
        sidescrolloff = 8; # Columns of context
        signcolumn = "yes"; # Always show the signcolumn, otherwise it would shift the text each time
        smartcase = true; # Don't ignore case with capitals
        smartindent = true; # Insert indents automatically
        spelllang = ["en"];
        splitbelow = true; # Put new windows below current
        splitkeep = "screen";
        splitright = true; # Put new windows right of current
        tabstop = 2; #
        termguicolors = true;
        undolevels = 10000;
        updatetime = 200; # Save swap file and trigger CursorHold
        virtualedit = "block"; # Allow cursor to move where there is no text in visual block mode
        wrap = false; # Disable line wrap
      };
      globals = {
        mapleader = " ";
      };
      extraPackages = with pkgs; [vimPlugins.nvim-web-devicons];
      clipboard = {
        register = "unnamedplus";
        providers = {
          wl-copy.enable = true;
          xclip.enable = true;
        };
      };
      keymaps = [
        {
          action = "<cmd>Telescope fd<CR>";
          key = "<leader><space>";
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<leader>/";
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>Telescope oldfiles<CR>";
          key = "<leader>fr";
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>Oil<CR>";
          key = "<leader>e";
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>bnext<CR>";
          key = "]b";
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>bprevious<CR>";
          key = "[b";
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>bnext<CR>";
          key = "<S-l>";
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>bprevious<CR>";
          key = "<S-h>";
          options = {
            silent = true;
          };
        }
        {
          action = "<cmd>BufferDelete<CR>";
          key = "<leader>bd";
          options = {
            silent = true;
          };
        }
        # {
        #   action = "<cmd>ToggleTerm<CR>";
        #   key = "<leader>ft";
        #   options = {
        #     silent = true;
        #   };
        # }
      ];
      plugins = {
        # coding
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            mapping = {
              "<Down>" = "cmp.mapping.select_next_item()";
              "<Up>" = "cmp.mapping.select_prev_item()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = " cmp.mapping.complete {}";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            };
            sources = [
              {name = "nvim_lsp";}
              {name = "path";}
              {name = "buffer";}
              {name = "luasnip";}
            ];
            snippet.expand = ''
              function(args)
                require "luasnip".lsp_expand(args.body)
              end
            '';
          };
        };
        luasnip.enable = true;
        cmp_luasnip.enable = true;

        # editors
        oil.enable = true;
        telescope = {
          enable = true;
          extensions = {
            fzf-native.enable = true;
          };
        };
        flash.enable = true;
        gitsigns.enable = true;
        # conform-nvim.enable = true;
        # lint.enable = true;

        # lsp
        lsp = {
          enable = true;
          servers = {
            nil_ls.enable = true;
          };
        };
        lspkind.enable = true;
        cmp-nvim-lsp.enable = true;

        # treesitter
        treesitter = {
          enable = true;
          nixvimInjections = true;
          settings = {
            ensure_installed = "all";
            incremental_selection = {
              enable = true;
              keymaps = {
                init_selection = "+";
                node_incremental = "+";
                node_decremental = "-";
              };
            };
          };
        };
        cmp-treesitter.enable = true;

        # ui
        bufferline = {
          enable = true;
        };
        lualine = {
          enable = true;
          iconsEnabled = true;
          componentSeparators = {
            left = " ";
            right = " ";
          };
          sectionSeparators = {
            left = " ";
            right = " ";
          };
        };
        indent-blankline = {
          enable = true;
          settings = {
            indent = {
              char = "│";
              tab_char = "│";
            };
          };
        };
        which-key.enable = true;

        # etc
        mini = {
          enable = true;
          modules = {
            pairs = {};
            surround = {};
            comment = {};
            ai = {};
            indentscope = {
              symbol = "│";
              options.try_as_border = true;
            };
            starter = {};
          };
        };
        direnv.enable = true;
        nix.enable = true;
        persistence.enable = true;
        toggleterm = {
          enable = true;
          settings.insert_mappings = true;
        };
      };
    };
  };

  home.sessionVariables.EDITOR = "nvim";
}
