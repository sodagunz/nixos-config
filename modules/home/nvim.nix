_: {
  programs.vim = {
    enable = true;
  };

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;
        preventJunkFiles = true;
        hideSearchHighlight = true;
        useSystemClipboard = true;
        bell = "visual";
        searchCase = "smart";
        undoFile.enable = true;

        lsp = {
          enable = true;
          formatOnSave = true; # format files on save, creates a backup
          lspkind.enable = true; # pictograms on LSP suggestions
          lightbulb.enable = true; # lightbulb when codeaction exists
          lspsaga.enable = false; # improved lsp experience
          trouble.enable = true; # improved diagnostics
          lspSignature.enable = true; # show function signature as you type
          otter-nvim.enable = true; # creates tmp subbuffer with only one language
          lsplines.enable = false; # renders diagnostics on virtual lines kinda like rustc
          nvim-docs-view.enable = false; # shows docs on a new panel #mapped to l by default which sucks
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          markdown.enable = true;
          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          html.enable = true;
          sql.enable = true;
          ts.enable = true;
          lua.enable = true;
          go.enable = true;
          python.enable = true;
          zig.enable = true;
          rust.enable = true;
          rust.crates.enable = true;
          ocaml.enable = true;
          haskell.enable = true;
          julia.enable = true;
        };

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true; #softened scrolling
          fidget-nvim.enable = true; #fidget spinner for notify

          highlight-undo.enable = true;
          indent-blankline.enable = true;

          cellular-automaton.enable = true;
        };

        minimap.codewindow.enable = true;

        statusline = {
          lualine = {
            enable = true;
            theme = "tokyonight";
          };
        };

        theme = {
          enable = true;
          name = "tokyonight";
          style = "night";
          transparent = false;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        autocomplete.nvim-cmp.mappings.confirm = "<S-CR>";
        snippets.luasnip.enable = true;

        filetree.neo-tree.enable = true; #TODO replace with oil

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
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              nix = "110";
              ruby = "120";
              java = "130";
              go = ["90" "130"];
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
