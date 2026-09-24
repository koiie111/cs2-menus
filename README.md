## Metamod 2.0 compatibility build

This fork currently builds the 1.8.7 plugin API with KHook for Metamod:Source 2.0.
It does not include the HUD layout features introduced in upstream 1.9.0/1.9.1.
The KHook and SDK compatibility changes were adapted from
[elnononono/cs2-menus](https://github.com/elnononono/cs2-menus).

GitHub Actions checks for a new Metamod 2.0 release every six hours and can also
be started manually with a `metamod_tag`. A successful build publishes a release
named `metamod-<version>` with `utils.zip`, `custom_menu.zip` and
`menu_buttons.zip`. The `utils.zip` archive contains `utils/utils.so`,
`metamod/utils.vdf`, `configs/`, and `translations/`. The signatures in
`configs/signatures.ini` come from the Metamod 2.0 compatible port and should be
checked again after a CS2 game update.

The build uses a known compatible HL2SDK and SchemaEntity revision. A future
Metamod release that changes its plugin API may require an SDK or source update;
the workflow only publishes when compilation and archive checks succeed.

The language setting is - addons/configs/core.cfg

Signatures - addons/configs/signatures.ini
