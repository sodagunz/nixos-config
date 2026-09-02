{ pkgs, ... }:
{
  home.packages = [ pkgs.zed-editor ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "nord-night";
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
  };

  programs.vim = {
    enable = true;
  };

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        preventJunkFiles = true;
        hideSearchHighlight = true;
        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy.enable = true;
        };
        bell = "visual";
        searchCase = "smart";
        undoFile.enable = true;

        assistant = {
          copilot = {
            enable = true;
            cmp.enable = false;
            setupOpts = {
              accept = "<S-CR>";
            };
          };
        };

        lsp = {
          enable = true;
          formatOnSave = false; # format files on save, creates a backup
          lspkind.enable = true; # pictograms on LSP suggestions
          lightbulb.enable = true; # lightbulb when codeaction exists
          lspsaga.enable = false; # improved lsp experience
          trouble.enable = true; # improved diagnostics
          lspSignature.enable = true; # show function signature as you type
          otter-nvim.enable = true; # creates tmp subbuffer with only one language
          nvim-docs-view.enable = false; # shows docs on a new panel #mapped to l by default which sucks
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          bash.enable = true;

          clang.enable = true;
          go.enable = true;
          elixir.enable = true;
          rust.enable = true;
          zig.enable = true;

          css.enable = true;
          html.enable = true;
          typescript.enable = true;
          sql.enable = true;

          lua.enable = true;

          python.enable = true;
          julia.enable = false; # Julia depot takes ages to build

          ocaml.enable = true;
          haskell.enable = true;

          markdown = {
            enable = true;
            extensions.render-markdown-nvim.enable = true;
          };
        };

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true; # softened scrolling
          fidget-nvim.enable = true; # fidget spinner for notify

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          cellular-automaton.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "nord";
            integrations.breadcrumbs = {
              nvim-navic.enable = true;
              navbuddy.enable = true;
            };
          };
        };

        theme = {
          enable = true;
          name = "nord";
          transparent = false;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        autocomplete.nvim-cmp.mappings.confirm = "<S-CR>";

        snippets.luasnip.enable = true;

        tabline.nvimBufferline.enable = true;

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = false; # visual aid for vim navigation
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        notify.nvim-notify.enable = true;

        projects.project-nvim.enable = true; # Never used before

        utility = {
          ccc.enable = false;
          surround.enable = true;
          diffview-nvim.enable = true;
          motion = {
            hop.enable = true;
            leap.enable = false;
            precognition.enable = false;
          };

          images.image-nvim.enable = false;
          snacks-nvim.enable = true;
          oil-nvim.enable = true;
          sleuth.enable = true;
          leetcode-nvim.enable = true;
          yazi-nvim.enable = true;
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          illuminate.enable = true;
          colorizer = {
            enable = true;
            setupOpts = {
              filetypes = {
                "*" = { };
              };
            };
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              rust = "120";
              nix = "110";
              ruby = "120";
              java = "130";
              go = [
                "90"
                "130"
              ];
            };
          };
          fastaction.enable = true;
        };

        comments.comment-nvim.enable = true;
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
