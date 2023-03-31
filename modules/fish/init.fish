set -U fish_greeting
set -x NIXPKGS_ALLOW_UNFREE 1

fish_add_path -a \
    $HOME/.bin \
    $GOPATH/bin \
    $HOME/.cargo/bin \
    $HOME/.nix-profile/bin \
    /nix/var/nix/profiles/default/bin \
    /usr/local/go/bin

set -a fish_complete_path $HOME/.nix-profile/share/fish/vendor_completions.d

function __trap_exit_tmux
    test -z "$NVIM_LISTEN_ADDRESS" || exit
    test -z "$NVIM" || exit
    test (tmux list-windows | count) = 1 || exit
    test (tmux list-panes | count) = 1 || exit
    tmux switch-client -t default
end

if status --is-interactive
    trap __trap_exit_tmux EXIT
end

if test -f ~/.localrc.fish
    source ~/.localrc.fish
end
