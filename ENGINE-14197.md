# Game Utils 1.8.7-14197

This is the 1.8.7 API with the CS2 1.41.9.7 network-message ABI and current
Metamod hooks. Existing IUtilsApi, IPlayersApi and IMenusApi layouts are retained.

The old TextMsg lookup used a removed INetworkMessages vtable slot and could
hang the game inside libnetworksystem. TextMsg and both SetConVar paths now use
the current 40-byte message descriptor and SDK protobuf envelope. Hooks use
KHook, schema fields use the current SDK names and serializer database, and
IsHearingClient is bound through its SDK vtable entry instead of an obsolete
byte signature. Detours are uninstalled before destroying their trampolines.

Build dependencies used for the Linux release:

- [AlliedModders S2SDK](https://github.com/alliedmodders/s2sdk) (folder `hl2sdk-cs2`): `81020d1a26b9d4321b9f030c96929ec18e8c0cff`
- Metamod: `170058a2f0dbd58106b7c76bfe88a94672295356`
- SchemaEntity: `e7965b3c83ec684d44584ee6457c5482ee5d9db1`, plus
  `patches/schema-14197.patch` from this repository
- AMBuild 2.2, Clang 14 with Ubuntu 22.04 / GCC 11 headers, Linux x86_64, C++20

Place SchemaEntity next to this repository, then apply the dependency patch:

```sh
git -C ../SchemaEntity checkout e7965b3c83ec684d44584ee6457c5482ee5d9db1
git -C ../SchemaEntity apply ../cs2-menus/patches/schema-14197.patch
mkdir build
cd build
CC=clang-14 CXX=clang++-14 python3 ../configure.py --enable-optimize --enable-debug \
  --sdks cs2 --targets x86_64 --hl2sdk-root /path/to/external \
  --mms_path /path/to/external/metamod-source \
  --hl2sdk-manifests /path/to/external/metamod-source/hl2sdk-manifests
ambuild
```

Use the current engine's `configs/signatures.ini`. Preserve the server's core
settings, translations, cookies and dependent plugins. Replace the binary with
the game stopped: dependent native plugins retain pointers to its API and cannot
be safely switched by unloading Game Utils underneath them. Do not activate this
binary on an older engine.

`utils_status` is server-console-only and reports map bindings, frame count,
TextMsg and SetConVar counts. `utils_abi_test <zero-based bot slot>` exercises
the three message paths on a bot. It does not target human players.

The release was exercised with bots through three map changes and TextMsg /
both SetConVar sends, then on the existing public server plugin stacks. These
checks do not constitute visual menu, human voice or every API feature acceptance.
