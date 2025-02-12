#!/bin/bash
git submodule update --remote --merge
git add .
git commit -m "Updated submodules"
git push origin main