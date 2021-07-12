function! go#expr#complete() abort
    silent write
    let values = json_decode(system(printf('go-expr-completion -pos %s -file %s', line2byte(line('.')) + (col('.') - 2), @%)))
    let start_line = byte2line(values.start_pos)
    let end_line = byte2line(values.end_pos)

    if getline(start_line) =~# '.*:='
        return
    end

    let num_start_line_indents = indent(start_line) / &tabstop
    let start_line_text = getline(start_line)
    let start_line_tabs = repeat("\t", num_start_line_indents)

    let len = len(values.values)
    if len == 0
        return
    endif


    if len > 1
        let names = []
        for v in values.values
            call add(names, v.name)
        endfor
        let lhs = join(names, ', ')

        let first_line = printf('%s%s := %s', start_line_tabs, lhs, trim(start_line_text, "\t"))

        if values.values[-1].type ==# 'error'
            let following_lines = [
                        \   printf('%sif %s != nil {', start_line_tabs, values.values[-1].name),
                        \   printf('%s}', start_line_tabs)
                        \ ]
        else
        end
    else
        let first_line = printf('%s := %s', values.values[0].name, trim(start_line_text, "\t"))
        let end_char = start_line_text[len(start_line_text) - 1]

        if values.values[0].type ==# 'error'
            if end_char ==# '{'
                let first_line = [printf('%s%s', start_line_tabs, first_line)]
                let following_lines = [
                            \   printf('%sif %s != nil{', start_line_tabs, values.values[0].name),
                            \   printf('%s}', start_line_tabs),
                            \ ]
            else
                let first_line = printf('%sif %s; %s != nil {', start_line_tabs, first_line, values.values[0].name)
                let following_lines = [
                            \   printf('%s}', start_line_tabs)
                            \ ]
            end
        else
            let first_line = [printf('%s%s', start_line_tabs, first_line)]
        endif

    endif

    call setline(start_line, first_line)
    if exists('following_lines')
        call append(end_line, following_lines)
    end

    call setpos('.', [0, start_line, num_start_line_indents + 1, 0])
endfunction
