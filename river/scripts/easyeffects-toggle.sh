#!/usr/bin/env fish

if test (easyeffects --bypass 3) -eq 1; easyeffects --bypass 2; else; easyeffects --bypass 1; end
