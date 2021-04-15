#!/bin/sh

# step 1
git clone https://github.com/vito/dot-nvim.git ~/.config/nvim --recursive

# there is no step 2

cat <<EOF
cheatsheet:
  normal mode:
    <Enter> - save
    <Space> - reset search highlight

    <C-hjkl> - faster window switching

    <C-c> - add cursor at position
    <C-d> - add cursor selecting current word, move to next occurrence
    <C-d> - add cursor selecting visual range, move to next occurrence
    ,x    - add cursor selecting given command (i.e. ,x$ to end of line)
    <Esc> - deselect all cursor selections

    ,u - toggle undo tree

    ,cc - fuzzy execute coc command
    ,cd - fuzzy select diagnostics
    ,ce - fuzzy list installed coc extensions
    ,cf or <C-p> - fuzzy find file
    ,cg - fuzzy grep across all files
    ,cm or <C-u> - fuzzy find most-recently-used file
    ,co - fuzzy find symbol across workspace
    ,co - fuzzy find symbol in open file
    ,cp - reopen last fuzzy pane

    ,cG - grep across workspace (i.e. Ag/Ack/Rg); opens pane with each occurrence
          editable with multi-cursors

    [g - previous diagnostic
    ]g - next diagnostic

    ,rn - rename function/var/etc

    :Format - reformat current file
    :OR     - organize imports

    gd - go to definition
    gy - go to definition of value's type
    gi - go to implementations of interface or method
    gr - go to references

  insert mode:
    jk - <esc>
    kj - <esc>
EOF
