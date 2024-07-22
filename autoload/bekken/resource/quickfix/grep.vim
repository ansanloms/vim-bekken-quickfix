vim9script

import autoload "bekken.vim" as b

const keyMapping = {
  "\<Cr>": "buffer",
  "\<Tab>": "tab split | buffer",
  "\<C-t>": "tab split | buffer",
  "\<C-s>": "split | buffer",
  "\<C-v>": "vsplit | buffer",
}

export def List(...args: list<any>): list<dict<any>>
  return getqflist()
    ->copy()
    ->map((key, val) => ({
      line: [
        bufname(val.bufnr),
        val.lnum .. " col " .. val.col .. "-" .. val.end_col,
        " " .. val.text,
      ]->join("|"),
      quickfix: val
    }))
enddef

export def Filter(key: string, bekken: b.Bekken): bool
  if keyMapping->has_key(key)
    const selected = bekken.GetResource().selected

    if selected != null
      execute(keyMapping[key] .. " " .. selected.quickfix.bufnr)
      cursor(selected.quickfix.lnum, selected.quickfix.col)
    endif

    bekken.Close()
  endif

  return true
enddef
