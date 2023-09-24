# auto start tmux
if [ $SHLVL = 1 ]; then
    TMUX_COUNT=$(ps -ax | grep '[t]mux' | wc -l)
    if [ $TMUX_COUNT -eq 0 ]; then
        tmux
    elif [ $TMUX_COUNT ]; then
        tmux a
    fi
fi
