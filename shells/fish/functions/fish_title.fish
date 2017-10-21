# Defined in /tmp/fish.au862c/fish_title.fish @ line 2
function fish_title
	if test -z $EMACS 
                if test $_ = 'fish'
                        echo (prompt_pwd)
                else
                        echo $_
                end
        else
                true
        end
end
