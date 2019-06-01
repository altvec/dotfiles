function caskupgrade -d "Upgrade installed casks"
    for item in (brew cask list)
        brew cask upgrade $item
    end
end
