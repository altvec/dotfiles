function pj -d "Pretty JSON"
    if test "$argv[1]" = "-C"
        # no color
        python -m json.tool
    else
        python -m json.tool | pygmentize -l json
    end
end
