#!/usr/bin/env bash
# Adapts pisex/SchemaEntity to the current hl2sdk cs2 branch and to what cs2-menus uses from it.
set -euo pipefail
cd "$1"

# hl2sdk #421 dropped the transitive include of gametrace.h (Ray_t, CHitBox, HitGroup_t)
sed -i '1i #include <gametrace.h>' globaltypes.h

# NetworkStateChanged_t was renamed to NetworkStateChangedData
sed -i 's/NetworkStateChanged_t/NetworkStateChangedData/g' schemasystem.cpp

# FL_CONTROLLER_FAKECLIENT / FL_PAWN_FAKECLIENT were replaced by FL_FAKECLIENT / FL_BOT
sed -i 's/FL_CONTROLLER_FAKECLIENT/FL_FAKECLIENT/g' CCSPlayerController.h
sed -i 's/FL_PAWN_FAKECLIENT/FL_BOT/g' CCSPlayerPawn.h

# PlayersApi::TakeDamage reads the pawn's damage react services
grep -q m_pDamageReactServices CCSPlayerPawn.h || \
	sed -i 's/^\(\s*\)SCHEMA_FIELD(QAngle, m_angEyeAngles);/&\n\1SCHEMA_FIELD(CCSPlayer_DamageReactServices*, m_pDamageReactServices);/' CCSPlayerPawn.h
grep -q m_pDamageReactServices CCSPlayerPawn.h
