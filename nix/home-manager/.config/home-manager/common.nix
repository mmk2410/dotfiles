{ config, pkgs, ...}:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    colordiff
    firefox
    jetbrains-mono
    keepassxc
    rlwrap
    open-sans

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/nvim/init.vim".source = ~/.dotfiles/neovim/.config/nvim/init.vim;
    ".config/flatpak-sync/apps.list".source = ~/.dotfiles/flatpak-sync/.config/flatpak-sync/apps.list;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
    # VISUAL = "emacs";
  };

  accounts.email.maildirBasePath = ".mbsync";

  ############
  # PROGRAMS #
  ############

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.vterm
    ];
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
    git = true;
  };

  programs.fish = {
    enable = true;

    shellAbbrs = {
      ping = "ping -c 3";
      pingtest = "ping -c 3 mmk2410.org";
      g = "git";
      s = "sudo";
    };

    shellAliases = {
      df = "df -h";
      du = "du -c -h";
      mkdir = "mkdir -p -v";
      ln = "ln -i";
      chown = "chown --preserve-root";
      chmod = "chmod --preserve-root";
      chgrp = "chgrp --preserve-root";
      ps = "ps aux k%cpu";
      o = "xdg-open";
      diff = "colordiff";
      sbcl = "rlwrap sbcl";
      "..." = "cd ../..";
    };

    plugins = [
      { name = "z"; src = pkgs.fishPlugins.z.src; }
      { name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
      { name = "foreign-env"; src = pkgs.fishPlugins.foreign-env.src; }
      {
        name = "emacs-vterm";
        src = ~/.dotfiles/fish/.config/fish/plugins/emacs-vterm;
      }
    ];

    interactiveShellInit = ''
      for f in ${pkgs.fishPlugins.hydro.src}/functions/*.fish
        source $f
      end
    '';
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Marcel Kapfer";
    extraConfig.init.defaultBranch = "main";
  };

  programs.gpg.enable = true;

  programs.htop.enable = true;

  programs.mbsync = {
    enable = true;
    extraConfig = "CopyArrivalDate yes\n\n";
  };

  programs.msmtp.enable = true;

  programs.mu.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.ssh.enable = true;

  services.emacs = {
    enable = true;
    client.enable = true;
    defaultEditor = true;
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    defaultCacheTtl = 14400;
    maxCacheTtl = 14400;
    pinentryFlavor = "gnome3";
  };

  services.mbsync = {
    enable = true;
    postExec = "${pkgs.emacs}/bin/emacsclient -equ '(mu4e-update-index)'";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
