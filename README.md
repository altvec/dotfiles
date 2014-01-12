dotfiles
========

This is my console life.

Before begin you need to install Apple Xcode Command Line Tools. Xcode is a large suit of software development tools and necessary libraries from Apple. The Xcode Command Line Tools are part of Xcode which can be installed separatly.

## OS X Mavericks (10.9)
To install Command Line Tools you should find Terminal.app (or better download iTerm2) and run it. OS X will alert you when you enter a command in the terminal that requires Xcode Command Line Tools. So, for example, you can type "git" (without quotes) and hit enter:

    $ git

Then you'll see an alert pop-up window telling something like this:
"The 'git' command requires the command line developer tools. Would you like to install the tools now?"
Click "install" to download and install Command Line Tools.

Verify that you have successfully installed Tools:

    $ xcode-select -p
    /Library/Developer/CommandLineTools

If you see message like above then you're set.
