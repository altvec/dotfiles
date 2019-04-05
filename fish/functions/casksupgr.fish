function casksupgr -d "Upgrade brew casks"
    for item in (brew cask list)
        brew cask upgrade $item
    end
end
