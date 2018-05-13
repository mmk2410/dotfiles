function gitignore_fisher_functions
    set functions_path ~/.config/fish/functions/
    if not test -e $functions_path
        echo "Functions directory not found"
    else
        cd $functions_path
        find * -type l > .gitignore
	echo "fisher.fish" >> .gitignore
        cd -
    end
end
