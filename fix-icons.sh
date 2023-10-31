#!/bin/sh

set -e

lua_file="lua/nvim-web-devicons/icons-default.lua"

gsed -i -r \
    -e 's||󰒓|g' \
    -e 's||󰱺|g' \
    -e 's||󰊢|g' \
    -e 's||󰮠|g' \
    -e 's|||g' \
    -e 's||󰛷|g' \
    -e 's||󰨞|g' \
    -e 's||󰴭|g' \
    -e 's|󰡨|󰡨|g' \
    -e 's||󰿃|g' \
    -e 's||󰍔|g' \
    -e 's|||g' \
    -e 's||󰎙|g' \
    -e 's||󰓎|g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's||󰙪|g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's||󰋹|g' \
    -e 's||󰙱|g' \
    -e 's||󰙲|g' \
    -e 's|⚙|󰒓|g' \
    -e 's||󰈮|g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's||󰅩|g' \
    -e 's||󰌜|g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's||󰆼|g' \
    -e 's||󰇄|g' \
    -e 's||󰆊|g' \
    -e 's||󰧑|g' \
    -e 's||󰇣|g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's||󰅴|g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's|󱈚|󱈚|g' \
    -e 's|🌜|🌜|g' \
    -e 's||󰆦|g' \
    -e 's||󰟓|g' \
    -e 's|||g' \
    -e 's||󰬏|g' \
    -e 's||󱗞|g' \
    -e 's||󰲒|g' \
    -e 's||󰌝|g' \
    -e 's||󰏢|g' \
    -e 's||󰬷|g' \
    -e 's|||g' \
    -e 's||󰌞|g' \
    -e 's||󰳪|g' \
    -e 's||󰜈|g' \
    -e 's||󱈙|g' \
    -e 's||󰐣|g' \
    -e 's||󰢱|g' \
    -e 's||󰍔|g' \
    -e 's||󰌪|g' \
    -e 's|λ|󰘧|g' \
    -e 's|∞|󰚾|g' \
    -e 's|||g' \
    -e 's||󱄅|g' \
    -e 's||󰈣|g' \
    -e 's|||g' \
    -e 's||󰛖|g' \
    -e 's||󰏓|g' \
    -e 's||󰈦|g' \
    -e 's||󰌟|g' \
    -e 's|||g' \
    -e 's||󰏒|g' \
    -e 's|󰨊|󰨊|g' \
    -e 's|||g' \
    -e 's||󰌠|g' \
    -e 's||󰐅|g' \
    -e 's|||g' \
    -e 's||󱘗|g' \
    -e 's||󰑫|g' \
    -e 's||󰟬|g' \
    -e 's|||g' \
    -e 's|ﬦ|󰘧|g' \
    -e 's|||g' \
    -e 's||󰬚|g' \
    -e 's|||g' \
    -e 's|󰜡||g' \
    -e 's||󰛥|g' \
    -e 's|||g' \
    -e 's||󰔉|g' \
    -e 's||󰈔|g' \
    -e 's||󰛦|g' \
    -e 's||󰜈|g' \
    -e 's|||g' \
    -e 's|||g' \
    -e 's||󰹭|g' \
    -e 's||󰈹|g' \
    -e 's||󰉁|g' \
    -e 's|󰞻|󰡪|g' \
    -e 's||󰌿|g' \
    -e 's|||g' \
    -e 's||󰆫|g' \
    -e 's||󰈔|g' \
    -e 's||󰝚|g' \
    -e 's||󰕧|g' \
    -e 's||󰠅|g' \
    -e 's||󰹳|g' \
    $lua_file

parent_range(){
  local key=$1
  echo "/^local $key = \{\$/,/^\}$"
}

child_renge(){
  local key=$1
  echo "/^\ \ \[\"$key\"\] = \{$/,/^\ \ \},$"
}

item_content(){
  local item_key=$1 local item_v=$2
  echo "\ \ \ \ $item_key = \"$item_v\","
}

item_modify(){
  local p_key=$1
  local e_key=$2
  local item_key=$3
  local item_v=$4
  if [ -z "$p_key" -o -z "$e_key" -o -z "$item_key" ]; then
    echo "[Error Item]: '$p_key' '$e_key' '$item_key' '$item_v'"
  fi
  local p_range=`parent_range "$p_key"`
  local c_range=`child_renge "$e_key"`
  local c_item=`item_content "$item_key" "$item_v"`
  if [ -n "$item_v" -a -z "$(gsed -nr "$p_range/{$c_range/{/^$c_item/p}}" $lua_file)" ]; then
    gsed -i -r "$p_range/{$c_range/{s|^\ \ \ \ $item_key = .*,\$|$c_item|g}}" $lua_file
    echo "[]$p_key >> $e_key: '$item_key=\"$item_v\"'"
  fi
}

icon_manage() {
  local p_key=$1
  local e_key=$2
  local icon=$3
  local color=$4
  local cterm_color=$5
  local name=$6
  if [ -z "$p_key" -o -z "$e_key" ]; then
    echo "[Error] '$p_key', '$e_key', '$icon', '$color', '$cterm_color', '$name'"
    return
  fi
  local p_key="icons_by_$p_key"
  local p_range=`parent_range "$p_key"`
  local c_range=`child_renge "$e_key"`

  if [ -n "$(gsed -nr "$p_range/{$c_range/p}" $lua_file)" ]; then
    item_modify "$p_key" "$e_key" "icon" "$icon"
    item_modify "$p_key" "$e_key" "color" "$color"
    item_modify "$p_key" "$e_key" "cterm_color" "$cterm_color"
    item_modify "$p_key" "$e_key" "name" "$name"
  else
    if [ -z "$icon" -o -z "$color" -o -z "$cterm_color" -o -z "$name" ]; then
      echo "[Error New] '$p_key', '$e_key', '$icon', '$color', '$cterm_color', '$name'"
      return
    fi
    local c_icon=`item_content "icon" "$icon"`
    local c_color=`item_content "color" "$color"`
    local c_cterm_color=`item_content "cterm_color" "$cterm_color"`
    local c_name=`item_content "name" "$name"`

    gsed -i -r "/^local $p_key = \{\$/a \  [\"$e_key\"] = {\n$c_icon\n$c_color\n$c_cterm_color\n$c_name\n  }," $lua_file
    echo "[󰐕]$p_key >> $e_key: '$icon' '$color' '$cterm_color' '$name'"
  fi
}

filename_icon() {
    icon_manage 'filename' "$1" "$2" "$3" "$4" "$5"
}

extension_icon() {
    icon_manage 'file_extension' "$1" "$2" "$3" "$4" "$5"
}

filename_icon '.editorconfig' '' '#41535b' '239' 'EditConfig'
filename_icon 'vite.config.ts' '󰉁' '#cbcb41' '185' 'Vite'
filename_icon 'vitest.config.ts' '󰉁' '#cbcb41' '185' 'Vitest'

extension_icon 'editorconfig' '' '#41535b' '239' 'EditConfig'
extension_icon 'sh' '' '#859900' '113' ''

