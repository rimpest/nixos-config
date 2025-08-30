{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Shell utilities
    direnv
    ripgrep
    fd
    jq
    btop
    tree
    fzf
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    initContent = ''
      export PATH=$HOME/.local/bin:$PATH
      
      # Activate Python virtualenv (creates if missing)
      function venv() {
        if [[ -d .venv ]]; then
          source .venv/bin/activate
        elif [[ -d venv ]]; then
          source venv/bin/activate
        else
          python -m venv .venv && source .venv/bin/activate
        fi
      }
      
      eval "$(starship init zsh)"
      eval "$(direnv hook zsh)"
    '';
    
    shellAliases = {
      rebuild = "nixos-rebuild switch --flake ~/nixos-config#nixos --use-remote-sudo";
      update = "nix flake update ~/nixos-config";
      
      py = "python";
      pytest = "python -m pytest";
      
      ll = "ls -lah";
      ".." = "cd ..";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      python = {
        detect_extensions = ["py"];
        detect_files = ["requirements.txt" "pyproject.toml" "Pipfile"];
      };
    };
  };
}