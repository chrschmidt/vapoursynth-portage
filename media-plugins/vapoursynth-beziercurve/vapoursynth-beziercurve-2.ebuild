# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3

DESCRIPTION="A plugin which adjust the clip via bezier curve"
HOMEPAGE="https://github.com/kewenyu/VapourSynth-BezierCurve"

EGIT_REPO_URI="https://github.com/kewenyu/${PN}"
EGIT_COMMIT="eadfc1372670b989e56845e6694b7be76fedf02b"
KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE="lto"

RDEPEND+="
	media-libs/vapoursynth
"
DEPEND="${RDEPEND}
"

DOCS=( "README.md" )


src_configure() {
	local emesonargs=(
		--libdir="/usr/$(get_libdir)/vapoursynth/"
		-Db_lto=$(usex lto true false)
	)
	meson_src_configure
}
