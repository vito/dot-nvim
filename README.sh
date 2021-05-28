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

    ,u - toggle undo tree

    ,ff - fuzzy find file
    ,fg - fuzzy grep across all files
    ,fb - fuzzy switch buffer
    ,fh - fuzzy vim help tags

    [d - previous diagnostic
    ]d - next diagnostic

    ,rn - rename function/var/etc

    gd - go to definition
    gy - go to definition of value's type
    gi - go to implementations of interface or method
    gr - go to references

  insert mode:
    jk - <esc>
    kj - <esc>
EOF
