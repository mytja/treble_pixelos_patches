# Treble patches for PixelOS
Patches for PixelOS unofficial GSI

## If patch application fails
The script will generate .rej files alongside failed files. Find all .rej files (can be done with `git status`) and apply rejections manually.

Make sure to delete .rej files after resolving rejections. After doing so, run `git add .`, proceeded by `git am --continue`.

If patch was already applied to the source and no .rej files were generated, run `git am --skip`.

## Commonly used for patch applying
1. `git am`
```bash
git am ~/pixelos/patches/0001-TrebleDroid/platform_.../....patch
```

2. If `git am` fails, attempt a 3-way merge
```bash
git am --3way ~/pixelos/patches/0001-TrebleDroid/platform_.../....patch
```

3. If 3-way merge fails, generate `.rej` files and apply patches manually
```bash
git am --reject ~/pixelos/patches/0001-TrebleDroid/platform_.../....patch
```
