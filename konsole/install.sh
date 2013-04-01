#!/bin/bash
for file in {gb.profile,Solarized\ Dark.colorscheme,Solarized\ Light.colorscheme}; do
	cp "$file" ~/.kde/share/apps/konsole/
done
