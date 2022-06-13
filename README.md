# Vim setup

## Installing plugins
Add plugins as submodules.

```
git submodule add --force http://github.com/foo/bar.git pack/git-plugins/start/bar
git commit -m "Added submodule bar"
```

### Remove plugin (submodule)
```
git submodule deinit pack/git-plugins/start/foo
git rm -r pack/git-plugins/start/foo
rm -r .git/modules/pack/git-plugins/start/foo
```

### Update plugins (submodule)
```
cd ~/.vim/pack/plugins/start/foo
git pull origin master
```

Review first after `git fetch origin master`, followed by `git merge`.

Don't forget to commit `git commit -m "Updated plugins"`

### Reload plugins
```
:packloadall
```

## Favourite commands

### Buffers, Windows & Tabs

| command | description |
| - | - |
| buffer# | Jump to buffer # |
| <C-W>T | Open current buffer in new tab |
| <C-W>= | Equalize the size of open windows |
| <C-W><C-R> | Swap splits |

### Navigation

| command | description |
| - | - |
| o | Insert blank line after and switch to insert mode |
| e | Move to the end of a word |
| w | Move forward to the beginning of a word |
| W | Move forward a WORD (any non-whitespace characters) |
| b | Move backward to the beginning of a word |
| zz | Center the current line within the window |
| zt | Bring the current line to the top of the window |
| zb | Bring the current line to the bottom of the window |
| C-f | Scroll down entire page |
| C-b | Scroll up entire page |

### Editing & Refactoring

#### Using vim.surround

| command | description | mode |
| - | - | - |
| cs | Change surrounding (cs) character, e.g. follow by "' for cs"' | normal |
| ds | Delete surroundings | normal |
| ys | Apply surrounding (you surround) to vim motion or text object | normal |
| yss | Apply surrounding (you surround) to vim motion or text object | normal |
| S | Wraps selection with argument | visual |

#### Replace instances of constant or variable

##### Using search, change & repeat
1. Search for an instance with /
2. Replace, e.g. using `cw`
3. Find next instance using `n`
4. Repeat command with `.`
5. Repeat 3 and 4 to do more instances
