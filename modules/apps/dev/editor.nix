{ ... }:
{
  flake.homeModules.editor =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.zed-editor ];
      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
      programs.nvf = {
        enable = true;
        settings = {
          vim = {
            assistant = {
              copilot = {
                cmp.enable = false;
                enable = true;
                setupOpts = {
                  accept = "<S-CR>";
                };
              };
            };
            autocomplete.nvim-cmp.enable = true;
            autocomplete.nvim-cmp.mappings.confirm = "<S-CR>";
            autopairs.nvim-autopairs.enable = true;
            bell = "visual";
            binds = {
              cheatsheet.enable = false; # visual aid for vim navigation
              whichKey.enable = true;
            };
            clipboard = {
              enable = true;
              providers.wl-copy.enable = true;
              registers = "unnamedplus";
            };
            comments.comment-nvim.enable = true;
            debugger = {
              nvim-dap = {
                enable = true;
                ui.enable = true;
              };
            };
            git = {
              enable = true;
              gitsigns.codeActions.enable = false;
              gitsigns.enable = true;
            };
            hideSearchHighlight = true;
            languages = {
              bash.enable = true;
              clang.enable = true;
              css.enable = true;
              elixir.enable = true;
              enableExtraDiagnostics = true;
              enableFormat = true;
              enableTreesitter = true;
              go.enable = true;
              haskell.enable = true;
              html.enable = true;
              julia.enable = false; # Julia depot takes ages to build
              lua.enable = true;
              markdown = {
                enable = true;
                extensions.render-markdown-nvim.enable = true;
              };
              nix.enable = true;
              ocaml.enable = true;
              python.enable = true;
              rust.enable = true;
              sql.enable = true;
              typescript.enable = true;
              zig.enable = true;
            };
            lsp = {
              enable = true;
              formatOnSave = false; # format files on save, creates a backup
              lightbulb.enable = true; # lightbulb when codeaction exists
              lspSignature.enable = true; # show function signature as you type
              lspkind.enable = true; # pictograms on LSP suggestions
              lspsaga.enable = false; # improved lsp experience
              nvim-docs-view.enable = false; # shows docs on a new panel #mapped to l by default which sucks
              otter-nvim.enable = true; # creates tmp subbuffer with only one language
              trouble.enable = true; # improved diagnostics
            };
            notify.nvim-notify.enable = true;
            preventJunkFiles = true;
            projects.project-nvim.enable = true; # Never used before
            searchCase = "smart";
            snippets.luasnip.enable = true;
            statusline = {
              lualine = {
                enable = true;
                integrations.breadcrumbs = {
                  navbuddy.enable = true;
                  nvim-navic.enable = true;
                };
                theme = "nord";
              };
            };
            tabline.nvimBufferline.enable = true;
            telescope.enable = true;
            theme = {
              enable = true;
              name = "nord";
              transparent = false;
            };
            treesitter.context.enable = true;
            ui = {
              borders.enable = true;
              colorizer = {
                enable = true;
                setupOpts = {
                  filetypes = {
                    "*" = { };
                  };
                };
              };
              fastaction.enable = true;
              illuminate.enable = true;
              noice.enable = true;
              smartcolumn = {
                enable = true;
                setupOpts.custom_colorcolumn = {
                  go = [
                    "90"
                    "130"
                  ];
                  java = "130";
                  nix = "110";
                  ruby = "120";
                  rust = "120";
                };
              };
            };
            undoFile.enable = true;
            utility = {
              ccc.enable = false;
              diffview-nvim.enable = true;
              images.image-nvim.enable = false;
              leetcode-nvim.enable = true;
              motion = {
                hop.enable = true;
                leap.enable = false;
                precognition.enable = false;
              };
              oil-nvim.enable = true;
              sleuth.enable = true;
              snacks-nvim.enable = true;
              surround.enable = true;
              yazi-nvim.enable = true;
            };
            viAlias = true;
            vimAlias = true;
            visuals = {
              cellular-automaton.enable = true;
              cinnamon-nvim.enable = true; # softened scrolling
              fidget-nvim.enable = true; # fidget spinner for notify
              highlight-undo.enable = true;
              indent-blankline.enable = true;
              nvim-cursorline.enable = true;
              nvim-scrollbar.enable = true;
              nvim-web-devicons.enable = true;
            };
          };
        };
      };
      programs.vim = {
        enable = true;
      };
    };
}
