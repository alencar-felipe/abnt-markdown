function concat(...) 
    local t = {}
    for n = 1,select("#",...) do
        local arg = select(n,...)
        if type(arg)=="table" then
            for _,v in ipairs(arg) do
                t[#t+1] = v
            end
        else
            t[#t+1] = arg
        end
    end
    return t
end

-- Filter images with this function if the target format is LaTeX.
if FORMAT:match 'latex' then
    function Image (elem)
        -- Surround all images with image-centering raw LaTeX.
        return concat(
            {pandoc.RawInline('latex', 
                    '\\begin{figure}[H]\n' ..
                    '\\centering\n' ..
                    '\\caption{\n'
            )},
            elem.caption,
            {pandoc.RawInline('latex', 
                    '}\n' ..
                    '\\includegraphics[width=' .. elem.attributes.width ..
                    '\\textwidth,height=\\textheight]{' ..
                    elem.src .. '}\n' ..
                    '\\source{' .. elem.attributes.source .. '}\n' ..
                    '\\end{figure}\n'
            )}
        )
    end
end