{ config, pkgs, ... }:

{
	nix.enable = true;
	nix.package = pkgs.nix;

	system.primaryUser = "srivatsavauswin";

	nixpkgs.config = {
    	# allowUnsupportedSystem = true;
    	# allowBroken = true;
    	allowUnfree = true;
	};

	ids.gids.nixbld = 350;

	nix.settings.experimental-features = ["nix-command" "flakes"];

	environment.variables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
		GIT_EDITOR = "nvim";
		ZDOTDIR = "/Users/srivatsavauswin/.config";
	};

	
	environment.systemPackages = with pkgs; [
		# SHELL
		git
		luajit
		neovim
		btop
		oh-my-zsh
		zsh
		tree
		fzf
		wget
		curl
		tmux
		ffmpeg
		ripgrep
		yt-dlp
		colima
		docker_28
		direnv
		nodejs_22


		# ZSH
		zsh-history-substring-search
		zsh-syntax-highlighting
		zsh-vi-mode
		
		# GUI APPS
		alacritty
		brave
		telegram-desktop
		# vlc

		
		nerd-fonts.jetbrains-mono
	];

	# SHELL
	programs.zsh = {
	  enable = true;
	  enableCompletion = true;
 	};
	  

	environment.shells = [ pkgs.zsh ];

	users.users.srivatsavauswin = {
		name = "srivatsavauswin";
		home = "/Users/srivatsavauswin";
	};

	system.stateVersion = 4;

}
