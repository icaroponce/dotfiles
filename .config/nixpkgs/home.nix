{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "icaro";
  home.homeDirectory = "/home/icaro";
  # targets.genericLinux.enable = true;


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    # neovim-unwrapped
    git
    zsh

    firefox
    zoxide 

    stylua
    sumneko-lua-language-server
    #
    # yarn
    # nodePackages.npm
    # nodePackages.typescript-language-server
    #
    ghcid
    # stack
    cabal2nix
    # cabal-install
    stylish-haskell
    # haskell-language-server
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
