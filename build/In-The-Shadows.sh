#!/bin/sh
echo -ne '\033c\033]0;InTheShadows\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/In-The-Shadows.x86_64" "$@"
