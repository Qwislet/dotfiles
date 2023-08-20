local M = {}

function M.split(direction, file)
    vim.notify("VSCodeCall" ..
                   (direction == "h" and "workbench.action.splitEditorDown" or "workbench.action.splitEditorRight"))

    if file ~= "" then
        vim.notify("VSCodeExtensionNotify open-file " .. vim.fn.expand(file) .. " all")
    end
end

function M.splitNew(direction, file)
    M.split(direction, file == "" and "__vscode_new__" or file)
end

function M.closeOtherEditors()
    vim.notify "workbench.action.closeEditorsInOtherGroups"
    vim.notify "workbench.action.closeOtherEditors"
end

function M.manageEditorSize(count, to)
    count = count or 1

    for i = 1, count do
        vim.notify(to == "increase" and "workbench.action.increaseViewSize" or "workbench.action.decreaseViewSize")
    end
end

vim.cmd [[
    command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
    command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
    command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
    command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
    command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

    nnoremap <silent> <C-w>s :call <SID>split('h')<CR>
    xnoremap <silent> <C-w>s :call <SID>split('h')<CR>

    nnoremap <silent> <C-w>v :call <SID>split('v')<CR>
    xnoremap <silent> <C-w>v :call <SID>split('v')<CR>

    nnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>
    xnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>


    nnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
    xnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>

    nnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    xnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    nnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    xnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    nnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    xnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    nnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    xnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>

    " Bind C-/ to vscode commentary since calling from vscode produces double comments due to multiple cursors
    xnoremap <silent> <C-/> :call Comment()<CR>
    nnoremap <silent> <C-/> :call Comment()<CR>

    nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>
]]

return M
